from flask import Flask, render_template, request, redirect, url_for, session
from flask_login import login_user, logout_user, UserMixin, LoginManager, login_manager, current_user
from werkzeug.security import generate_password_hash, check_password_hash
import mysql.connector as connector
from flask_sqlalchemy import SQLAlchemy
import smtplib
from email.message import EmailMessage

app = Flask(__name__)
app.config['SECRET_KEY'] = 'secret'
app.config['SQLALCHEMY_DATABASE_URI']='mysql://root:''@localhost/biblioteca_projeto'
Login_manager= LoginManager(app)
db1 = SQLAlchemy(app)

@Login_manager.user_loader
def get_user(user_id):
    return User.query.filter_by(lei_id=user_id).first()

class User(UserMixin, db1.Model):
    __tablename__= 'leitores'
    lei_id= db1.Column(db1.Integer, autoincrement=True, primary_key=True)
    lei_nome= db1.Column(db1.String(86), nullable=False)
    lei_email= db1.Column(db1.String(86), nullable=False)
    lei_telefone= db1.Column(db1.Integer,nullable=False)
    lei_data_nascimento= db1.Column(db1.String(86), nullable=False)
    lei_data_cadastro= db1.Column(db1.String(86), nullable=False)
    lei_senha= db1.Column(db1.String(455), nullable=False)

    def __init__(self):
        self.host="localhost"
        self.user="root"
        self.password=""
        self.database="biblioteca_projeto"
        self.conn= self.connecting()

    def connecting(self):
        return connector.connect(
            database=self.database,
            user=self.user,
            password=self.password,
            host=self.host
        )
    def cadastrar(self, nome, email, senha):
        self.nome=nome
        self.email=email
        self.lei_senha=generate_password_hash(senha)
        cursor=self.conn.cursor()
        cursor.execute("""insert into leitores(lei_nome, lei_email, lei_senha) 
                       values(%s, %s, %s)""", (self.nome, self.email, self.lei_senha))
        self.conn.commit()
        cursor.close()

    def verify_password(self, sen):
        return check_password_hash(self.lei_senha, sen)

    def querying(self, query):
        if not self.conn.is_connected():
            self._connect()

    def get_id(self):
        return str(self.lei_id)
    
    def get_livros(self):
        if not self.conn.is_connected():
            self.conn = self.connecting()
        cursor = self.conn.cursor()
        cursor.execute("SELECT * FROM livros")
        lista = cursor.fetchall()
        cursor.close()

        return lista
    
    def get_livro_info(self, valor):
        if not self.conn.is_connected():
            self.conn = self.connecting()
        cursor = self.conn.cursor()
        cursor.execute("SELECT * FROM livros WHERE liv_id=%s", (valor,))
        lista = cursor.fetchone()
        cursor.close()

        return lista
    
    def reservar_liv(self, id):
        self.id=id
        cursor=self.conn.cursor()
        cursor.execute("""UPDATE livros SET liv_disponibilidade = %s WHERE liv_id = %s""", (0,self.id))
        self.conn.commit()
        cursor.close()

    def enviar_email(self, email):  
        corpo_email = """
        <p>Cadastrado!</p>
        """

        msg = EmailMessage()
        msg['Subject'] = "Assunto"
        msg['From'] = 'ps1projetot1@gmail.com'
        msg['To'] = email
        password = 'rjqfaekacaqxemhz' 
        msg.add_header('Content-Type', 'text/html')
        msg.set_payload(corpo_email )

        s = smtplib.SMTP('smtp.gmail.com: 587')
        s.starttls()
        # Login Credentials for sending the mail
        s.login(msg['From'], password)
        s.sendmail(msg['From'], [msg['To']], msg.as_string().encode('utf-8'))
        

    
    
db=User()

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/cadastro", methods= ["GET","POST"])
def cadastro():
    if request.method == 'POST':
        nome= request.form["nome"]
        email= request.form["email"]
        psw= request.form["senha"]

        db.cadastrar(nome, email, psw)
        db.enviar_email(email)

        return redirect(url_for("cadastro"))
    else:    
        return render_template("cadastro.html")

@app.route("/login", methods=["GET","POST"])
def login():
    if request.method == "POST":
        email = request.form["email"]
        sen = request.form["senha"]

        user = User.query.filter_by(lei_email=email).first()

        if not user or not user.verify_password(sen):
            return redirect(url_for("login"))
        
        else:
            login_user(user)
            return redirect(url_for("emprestimos"))
    else:
        return render_template("login.html")


@app.route('/emprestimos')
def emprestimos():
    if current_user.is_authenticated:
        lista=db.get_livros()
        return render_template('emprestimos.html', lista = lista)
    else:
        return redirect(url_for("login"))
    
@app.route('/logout')
def logout():
    if current_user.is_authenticated:
        logout_user()
        return redirect(url_for("login"))
    else:
        return redirect(url_for("login"))
    
@app.route('/informacoes', methods=["GET","POST"])
def informacoes():
        if request.method == "POST":
            valor = request.form.get('valor')
            lista = db.get_livro_info(valor)
            return render_template('informacoes.html', lista=lista)
        else:
            return render_template('emprestimos.html')

@app.route('/reserva', methods=["GET","POST"])
def reserva():
    if request.method == "POST":
            id = request.form.get('id')
            db.reservar_liv(id)
            return render_template('reserva.html')