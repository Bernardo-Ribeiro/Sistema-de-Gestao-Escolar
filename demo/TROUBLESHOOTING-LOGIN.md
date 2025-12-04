# 🔐 Guia de Solução de Problemas - Login e Autenticação

## ❌ Problema: "Não consigo fazer login" ou "Nenhum usuário encontrado"

### 🔍 Diagnóstico Rápido

Execute estes passos para identificar o problema:

#### 1️⃣ Verificar se o Banco de Dados está Rodando

```powershell
# Verificar status do MySQL
Get-Service MySQL*

# Se não estiver rodando, inicie:
Start-Service MySQL80
```

#### 2️⃣ Verificar se o Banco `sge` Existe

```powershell
# Conecte ao MySQL
mysql -u root -p

# Digite a senha e execute:
SHOW DATABASES;

# Deve aparecer 'sge' na lista
```

Se o banco não existir:
```sql
CREATE DATABASE sge DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

#### 3️⃣ Verificar se a Tabela `usuario` Existe

```sql
USE sge;
SHOW TABLES;
```

Deve listar: `aluno`, `curso`, `matricula`, `aula`, `presenca`, `advertencia`, **`usuario`**

Se a tabela `usuario` não existir, significa que o Hibernate não criou. Verifique:

```sql
-- Verificar estrutura da tabela usuario
DESCRIBE usuario;
```

#### 4️⃣ Verificar se Há Usuários Cadastrados

```sql
USE sge;
SELECT * FROM usuario;
```

Se retornar vazio (0 rows), **esse é o problema!**

---

## ✅ Soluções

### Solução 1: Usar o Inicializador Automático (Recomendado)

O sistema agora possui um **DatabaseInitializer** que cria usuários automaticamente na primeira execução.

**Passos:**

1. **Pare o servidor Jetty** (se estiver rodando): `Ctrl+C`

2. **Recompile o projeto**:
   ```powershell
   mvn clean install
   ```

3. **Inicie novamente**:
   ```powershell
   mvn jetty:run
   ```

4. **Observe o console** - deve aparecer:
   ```
   ========================================
   🚀 Inicializando Sistema EduGestão...
   ========================================
   ⚙️  Nenhum usuário encontrado. Criando usuários padrão...
      ✓ Admin criado - Login: admin / Senha: admin123
      ✓ Coordenador criado - Login: coordenador / Senha: coord123
      ✓ Secretaria criado - Login: secretaria / Senha: sec123
      ✓ Professor criado - Login: professor / Senha: prof123
   ✅ Usuários padrão criados com sucesso!
   
   📋 Usuários disponíveis para login:
      👤 admin (ADMIN)
      👤 coordenador (COORDENADOR)
      👤 secretaria (SECRETARIA)
      👤 professor (PROFESSOR)
   
   ========================================
   🌐 Sistema pronto para uso!
   🔗 Acesse: http://localhost:9090/sge/login
   👤 Login padrão: admin / admin123
   ========================================
   ```

5. **Acesse** http://localhost:9090/sge/login

6. **Faça login** com:
   - **Usuário:** `admin`
   - **Senha:** `admin123`

---

### Solução 2: Usar a Página de Setup Manual

Se o inicializador automático não funcionar:

1. **Acesse**: http://localhost:9090/sge/setup-usuarios

2. A página irá:
   - Verificar a conexão com o banco
   - Criar usuários padrão se não existirem
   - Listar todos os usuários cadastrados

3. **Após criar os usuários**, volte para: http://localhost:9090/sge/login

---

### Solução 3: Criar Usuários Manualmente via SQL

Se as soluções anteriores não funcionarem, crie manualmente:

```sql
USE sge;

-- Limpar tabela (opcional)
TRUNCATE TABLE usuario;

-- Criar usuário Admin
INSERT INTO usuario (usuario, senha, nome, email, perfil, ativo, data_criacao) 
VALUES ('admin', 'admin123', 'Administrador do Sistema', 'admin@edugestao.com', 'ADMIN', 1, NOW());

-- Criar usuário Coordenador
INSERT INTO usuario (usuario, senha, nome, email, perfil, ativo, data_criacao) 
VALUES ('coordenador', 'coord123', 'Coordenador Pedagógico', 'coordenador@edugestao.com', 'COORDENADOR', 1, NOW());

-- Criar usuário Secretaria
INSERT INTO usuario (usuario, senha, nome, email, perfil, ativo, data_criacao) 
VALUES ('secretaria', 'sec123', 'Secretária Escolar', 'secretaria@edugestao.com', 'SECRETARIA', 1, NOW());

-- Verificar
SELECT id, usuario, nome, perfil, ativo FROM usuario;
```

---

## 🧪 Página de Debug

Para diagnosticar problemas de autenticação, acesse:

**http://localhost:9090/sge/debug-usuarios**

Esta página mostrará:
- ✅ Status da conexão com banco
- 📊 Total de usuários cadastrados
- 📋 Lista completa de usuários
- 🔐 Teste de autenticação em tempo real
- 🔍 Logs de debug detalhados

**⚠️ IMPORTANTE:** Remova ou proteja esta página em produção!

---

## 📝 Credenciais Padrão

Após a inicialização, você terá estes usuários:

| Usuário | Senha | Perfil | Email |
|---------|-------|--------|-------|
| **admin** | admin123 | ADMIN | admin@edugestao.com |
| **coordenador** | coord123 | COORDENADOR | coordenador@edugestao.com |
| **secretaria** | sec123 | SECRETARIA | secretaria@edugestao.com |
| **professor** | prof123 | PROFESSOR | professor@edugestao.com |

---

## ❌ Erros Comuns e Soluções

### Erro: "Communications link failure"

**Causa:** MySQL não está rodando ou não está acessível.

**Solução:**
```powershell
# Verificar status
Get-Service MySQL*

# Iniciar serviço
Start-Service MySQL80
```

---

### Erro: "Access denied for user 'root'@'localhost'"

**Causa:** Senha incorreta no `hibernate.cfg.xml`.

**Solução:**
1. Abra `src/main/resources/hibernate.cfg.xml`
2. Corrija a senha:
   ```xml
   <property name="hibernate.connection.password">SUA_SENHA_AQUI</property>
   ```
3. Recompile: `mvn clean install`

---

### Erro: "Unknown database 'sge'"

**Causa:** Banco de dados não foi criado.

**Solução:**
```sql
mysql -u root -p
CREATE DATABASE sge;
EXIT;
```

---

### Erro: "Table 'sge.usuario' doesn't exist"

**Causa:** Hibernate não criou a tabela (problema no `hbm2ddl.auto`).

**Solução 1 - Verificar configuração:**
```xml
<!-- Em hibernate.cfg.xml, deve estar: -->
<property name="hbm2ddl.auto">update</property>
```

**Solução 2 - Criar tabela manualmente:**
```sql
USE sge;

CREATE TABLE usuario (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    perfil VARCHAR(20),
    ativo BOOLEAN DEFAULT TRUE,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultimo_acesso DATETIME,
    CONSTRAINT uk_usuario UNIQUE (usuario)
);
```

---

### Erro: "Usuario ou senha inválidos" (mesmo com credenciais corretas)

**Causa:** Senhas podem estar com hash ou espaços extras.

**Solução:**
1. Acesse: http://localhost:9090/sge/debug-usuarios
2. Verifique os dados exatos da tabela
3. Compare as senhas armazenadas com as que você está digitando
4. Se necessário, atualize manualmente:
   ```sql
   UPDATE usuario SET senha = 'admin123' WHERE usuario = 'admin';
   ```

---

## 🔄 Reset Completo do Sistema

Se nada funcionar, faça um reset completo:

```powershell
# 1. Pare o servidor
Ctrl+C

# 2. Conecte ao MySQL
mysql -u root -p

# 3. Recrie o banco
DROP DATABASE IF EXISTS sge;
CREATE DATABASE sge;
EXIT;

# 4. Limpe o cache do Maven
mvn clean

# 5. Recompile
mvn clean install

# 6. Inicie novamente
mvn jetty:run
```

O sistema irá:
- ✅ Criar todas as tabelas automaticamente
- ✅ Inserir usuários padrão
- ✅ Estar pronto para uso

---

## 📊 Verificação Final

Depois de aplicar as soluções, verifique:

```sql
USE sge;

-- Deve retornar 4 usuários
SELECT COUNT(*) as total FROM usuario;

-- Deve listar todos os usuários
SELECT id, usuario, nome, perfil, ativo FROM usuario;

-- Testar autenticação direta
SELECT * FROM usuario WHERE usuario = 'admin' AND senha = 'admin123' AND ativo = 1;
```

Se retornar 1 registro na última query, **o login deve funcionar!**

---

## 🆘 Suporte Adicional

Se ainda tiver problemas:

1. ✅ Verifique os logs do console do Jetty
2. ✅ Acesse `/debug-usuarios` para diagnóstico detalhado
3. ✅ Verifique se todas as tabelas foram criadas: `SHOW TABLES;`
4. ✅ Confirme que o Hibernate está configurado corretamente
5. ✅ Teste a conexão manualmente com `mysql -u root -p`

---

**💡 Dica:** Mantenha o terminal/console do Maven visível durante a execução. Ele mostra informações importantes sobre a inicialização e possíveis erros.

**🔒 Segurança:** Após configurar o sistema em produção, altere todas as senhas padrão!

---

**Última atualização:** Dezembro 2025  
**Versão:** 1.1
