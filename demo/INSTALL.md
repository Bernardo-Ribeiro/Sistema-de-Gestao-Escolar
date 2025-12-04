# 🚀 Guia de Instalação e Execução - Sistema de Gestão Escolar

Este documento contém todas as instruções necessárias para configurar e executar o Sistema de Gestão Escolar (SGE) em sua máquina.

## 📋 Pré-requisitos

Antes de começar, certifique-se de ter instalado:

### 1. **Java Development Kit (JDK) 21**
- **Download**: https://www.oracle.com/java/technologies/downloads/#java21
- **Verificar instalação**:
  ```powershell
  java -version
  ```
  Deve retornar: `java version "21.x.x"`

### 2. **Apache Maven 3.9+**
- **Download**: https://maven.apache.org/download.cgi
- **Configuração**:
  1. Extraia o arquivo ZIP em `C:\apache-maven`
  2. Adicione ao PATH: `C:\apache-maven\bin`
- **Verificar instalação**:
  ```powershell
  mvn -version
  ```

### 3. **MySQL Server 8.0+**
- **Download**: https://dev.mysql.com/downloads/mysql/
- **Configuração**:
  - Durante a instalação, defina a senha do usuário `root`
  - Anote a senha (você precisará dela na configuração)

### 4. **Git** (para clonar o repositório)
- **Download**: https://git-scm.com/downloads
- **Verificar instalação**:
  ```powershell
  git --version
  ```

## 📥 Passo 1: Clonar o Repositório

```powershell
# Clone o repositório
git clone https://github.com/Bernardo-Ribeiro/Sistema-de-Gestao-Escolar.git

# Entre no diretório do projeto
cd Sistema-de-Gestao-Escolar\demo
```

## 🗄️ Passo 2: Configurar o Banco de Dados

### 2.1 Criar o Banco de Dados

1. **Inicie o MySQL Server** (se não estiver rodando)

2. **Conecte-se ao MySQL**:
   ```powershell
   mysql -u root -p
   ```
   Digite a senha do root quando solicitado.

3. **Execute o script de criação** (opcional - o Hibernate cria automaticamente):
   ```sql
   CREATE DATABASE IF NOT EXISTS sge
     DEFAULT CHARACTER SET utf8mb4
     DEFAULT COLLATE utf8mb4_unicode_ci;
   
   USE sge;
   ```

4. **Saia do MySQL**:
   ```sql
   EXIT;
   ```

### 2.2 Configurar as Credenciais

Edite o arquivo `src/main/resources/hibernate.cfg.xml`:

```xml
<property name="hibernate.connection.url">
    jdbc:mysql://localhost:3306/sge?useTimezone=true&amp;serverTimezone=UTC
</property>
<property name="hibernate.connection.username">root</property>
<property name="hibernate.connection.password">SUA_SENHA_AQUI</property>
```

**Importante**: Substitua `SUA_SENHA_AQUI` pela senha do seu usuário root do MySQL.

## 🔧 Passo 3: Compilar o Projeto

No diretório `demo/`, execute:

```powershell
# Limpar e compilar o projeto
mvn clean install
```

Este comando irá:
- ✅ Baixar todas as dependências necessárias
- ✅ Compilar o código Java
- ✅ Gerar o arquivo WAR
- ✅ Executar testes (se houver)

**Saída esperada**: `BUILD SUCCESS`

## 🚀 Passo 4: Executar a Aplicação

### Opção 1: Usar o Jetty Maven Plugin (Recomendado)

```powershell
mvn jetty:run
```

**Resultado**:
- 🌐 Servidor iniciado em: http://localhost:9090/sge
- ⏹️ Para parar: Pressione `Ctrl+C`

### Opção 2: Usar Apache Tomcat

1. **Baixe o Tomcat 10+**: https://tomcat.apache.org/download-10.cgi

2. **Gere o arquivo WAR**:
   ```powershell
   mvn clean package
   ```

3. **Deploy**:
   - Copie `target/demo-1.0-SNAPSHOT.war` para `<TOMCAT_HOME>/webapps/sge.war`
   - Inicie o Tomcat: `<TOMCAT_HOME>/bin/startup.bat`

4. **Acesse**: http://localhost:8080/sge

## 🌐 Passo 5: Acessar a Aplicação

Abra o navegador e acesse:

```
http://localhost:9090/sge
```

### Funcionalidades Disponíveis:

1. **Dashboard** (Página Inicial)
   - URL: http://localhost:9090/sge/
   - Visualizar estatísticas do sistema

2. **Gestão de Alunos**
   - URL: http://localhost:9090/sge/alunos
   - Listar, cadastrar, editar e excluir alunos

3. **Gestão de Cursos**
   - URL: http://localhost:9090/sge/cursos
   - Listar, cadastrar, editar e excluir cursos

## 🔍 Verificações e Troubleshooting

### ✅ Verificar se o Banco de Dados está Funcionando

```powershell
mysql -u root -p -e "SHOW DATABASES;"
```

Deve listar o banco `sge`.

### ✅ Verificar Tabelas Criadas

```sql
USE sge;
SHOW TABLES;
```

Deve listar: `aluno`, `curso`, `matricula`, `aula`, `presenca`, `advertencia`

### ❌ Erro: "Access denied for user 'root'@'localhost'"

**Solução**: Verifique a senha no arquivo `hibernate.cfg.xml`

### ❌ Erro: "Communications link failure"

**Solução**: 
1. Verifique se o MySQL está rodando:
   ```powershell
   Get-Service MySQL*
   ```
2. Se não estiver, inicie:
   ```powershell
   Start-Service MySQL80
   ```

### ❌ Erro: "Port 9090 already in use"

**Solução**: Altere a porta no `pom.xml`:
```xml
<httpConnector>
    <port>8888</port>  <!-- Use outra porta disponível -->
</httpConnector>
```

### ❌ Erro: "java.lang.ClassNotFoundException: com.mysql.cj.jdbc.Driver"

**Solução**: Execute novamente:
```powershell
mvn clean install
```

## 🛠️ Comandos Úteis do Maven

```powershell
# Limpar compilação anterior
mvn clean

# Compilar sem executar
mvn compile

# Executar testes
mvn test

# Gerar arquivo WAR
mvn package

# Limpar, compilar e instalar
mvn clean install

# Executar com Jetty
mvn jetty:run

# Pular testes durante compilação
mvn clean install -DskipTests
```

## 📊 Estrutura do Projeto

```
demo/
├── pom.xml                          # Configuração Maven
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/sge/
│   │   │       ├── controller/      # Servlets (AlunoServlet, CursoServlet, etc.)
│   │   │       ├── dao/             # Camada de acesso a dados
│   │   │       ├── model/           # Entidades (Aluno, Curso, Matrícula, etc.)
│   │   │       └── util/            # HibernateUtil
│   │   ├── resources/
│   │   │   ├── hibernate.cfg.xml   # Configuração do Hibernate
│   │   │   └── database.sql        # Script SQL (opcional)
│   │   └── webapp/
│   │       ├── index.jsp            # Página inicial (Dashboard)
│   │       ├── WEB-INF/
│   │       │   ├── web.xml          # Configuração web
│   │       │   └── views/           # JSPs (alunos, cursos)
│   │       └── css/
│   │           └── style.css        # Estilos
│   └── test/                        # Testes (se houver)
└── target/                          # Arquivos compilados (gerado pelo Maven)
```

## 🎯 Tecnologias Utilizadas

| Tecnologia | Versão | Função |
|------------|--------|--------|
| **Java** | 21 | Linguagem de programação |
| **Jakarta EE** | 10.0.0 | Plataforma web enterprise |
| **Hibernate** | 6.4.0 | ORM (mapeamento objeto-relacional) |
| **MySQL** | 8.0+ | Banco de dados relacional |
| **Maven** | 3.9+ | Gerenciamento de dependências |
| **Jetty** | 11.0.18 | Servidor de aplicação |
| **JSP/JSTL** | 3.0 | Páginas dinâmicas |

## 📝 Configurações Importantes

### Porta do Servidor
- **Padrão**: 9090
- **Alterar em**: `pom.xml` → `<httpConnector><port>`

### Contexto da Aplicação
- **Padrão**: `/sge`
- **Alterar em**: `pom.xml` → `<webApp><contextPath>`

### Banco de Dados
- **Host**: localhost
- **Porta**: 3306
- **Database**: sge
- **Usuário**: root
- **Senha**: Definir em `hibernate.cfg.xml`

### Modo de Atualização do Schema
- **Padrão**: `update` (atualiza automaticamente)
- **Opções**:
  - `create`: Recria tabelas toda vez (CUIDADO: apaga dados!)
  - `create-drop`: Cria e apaga ao final
  - `validate`: Apenas valida o schema
  - `update`: Atualiza incrementalmente (recomendado)

## 🧪 Testando a Aplicação

### 1. Cadastrar um Aluno
1. Acesse: http://localhost:9090/sge/alunos
2. Clique em "Novo Aluno"
3. Preencha os dados:
   - Nome: João Silva
   - Matrícula: 2024001
   - Email: joao@email.com
   - Telefone: 11999999999
4. Clique em "Salvar"

### 2. Cadastrar um Curso
1. Acesse: http://localhost:9090/sge/cursos
2. Clique em "Novo Curso"
3. Preencha os dados:
   - Nome: Matemática Básica
   - Descrição: Curso introdutório de matemática
   - Carga Horária: 80
4. Clique em "Salvar"

### 3. Verificar Dashboard
1. Acesse: http://localhost:9090/sge/
2. Veja as estatísticas atualizadas

## 🔐 Segurança

⚠️ **Importante para Produção**:
- Não use `root` como usuário do banco
- Crie um usuário específico com permissões limitadas:
  ```sql
  CREATE USER 'sge_user'@'localhost' IDENTIFIED BY 'senha_forte';
  GRANT ALL PRIVILEGES ON sge.* TO 'sge_user'@'localhost';
  FLUSH PRIVILEGES;
  ```
- Não commite senhas no Git (use variáveis de ambiente)

## 📚 Próximos Passos

Após executar com sucesso, você pode:
1. ✅ Explorar as funcionalidades existentes
2. 📊 Visualizar os diagramas UML em `docs/`
3. 🔧 Adicionar novas funcionalidades
4. 🧪 Implementar testes automatizados
5. 🎨 Melhorar a interface com Bootstrap/Tailwind

## 🆘 Suporte

Se encontrar problemas:
1. Verifique os logs no console do Maven/Jetty
2. Consulte a seção de Troubleshooting
3. Verifique se todas as dependências foram baixadas corretamente
4. Confira as configurações do banco de dados

## 📄 Licença

Este projeto é um sistema acadêmico desenvolvido para fins educacionais.

---

**Desenvolvido por:** Bernardo Ribeiro  
**Última atualização:** Dezembro 2025  
**Versão:** 1.0

---

### 🎉 Pronto para começar!

Execute `mvn jetty:run` e acesse http://localhost:9090/sge 🚀
