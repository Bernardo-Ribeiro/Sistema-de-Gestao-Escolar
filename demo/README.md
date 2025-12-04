# 🎓 EduGestão - Sistema de Gestão Escolar

Sistema completo de gestão escolar desenvolvido com Java, JSP, Hibernate e MySQL.

## 🚀 Como Executar

### Opção 1: Usando o script (RECOMENDADO)
```cmd
cd c:\Github\Sistema-de-Gestao-Escolar\demo
run.bat
```

### Opção 2: Manual
```cmd
cd c:\Github\Sistema-de-Gestao-Escolar\demo
mvn jetty:run
```

## 🔐 Credenciais de Acesso

- **URL:** http://localhost:9090/sge/login
- **Usuário:** admin
- **Senha:** admin123

## 🛠️ Scripts Disponíveis

### `run.bat`
Inicia o servidor com limpeza automática de cache.

### `clean.bat`
Limpa completamente o projeto e recompila.

### `fix-jsp.ps1`
Corrige problemas de encoding nos arquivos JSP (PowerShell).

## 📝 Funcionalidades

- ✅ Sistema de Login e Autenticação
- ✅ Gerenciamento de Alunos (CRUD)
- ✅ Gerenciamento de Cursos (CRUD)
- ✅ Gerenciamento de Aulas (CRUD)
- ✅ Gerenciamento de Matrículas (CRUD)
- ✅ Sistema de Registro de Presenças
- ✅ Dashboard com estatísticas
- ✅ Design moderno e responsivo

## 🎨 Tecnologias

- **Backend:** Java 17, Jakarta EE, Hibernate
- **Frontend:** JSP, JSTL, CSS3
- **Banco de Dados:** MySQL 8
- **Servidor:** Jetty (Maven Plugin)
- **Build:** Maven

## 🔧 Solução de Problemas

### Erro HTTP 500 - ClassNotFoundException

Execute o script de limpeza:
```cmd
clean.bat
```

Ou manualmente:
```cmd
rmdir /s /q target
mvn clean compile
mvn jetty:run
```

### Problemas com JSP

Execute o fix:
```powershell
powershell -ExecutionPolicy Bypass -File fix-jsp.ps1
```

### Servidor não inicia

1. Verifique se a porta 9090 está livre
2. Limpe o cache: `rmdir /s /q target`
3. Recompile: `mvn clean compile`
4. Execute novamente: `mvn jetty:run`

## 📂 Estrutura do Projeto

```
demo/
├── src/main/
│   ├── java/com/sge/
│   │   ├── controller/    # Servlets
│   │   ├── dao/          # Data Access Objects
│   │   ├── model/        # Entidades
│   │   ├── filter/       # Filtros (Auth)
│   │   └── util/         # Utilities (Hibernate)
│   ├── webapp/
│   │   ├── css/          # Estilos
│   │   ├── WEB-INF/
│   │   │   ├── views/    # JSPs das páginas
│   │   │   └── web.xml   # Configuração
│   │   ├── index.jsp     # Dashboard
│   │   └── login.jsp     # Login
│   └── resources/
│       ├── hibernate.cfg.xml  # Config Hibernate
│       └── database.sql       # Script SQL
└── pom.xml               # Maven config
```

## 🎯 Próximos Passos

- [ ] Adicionar gráficos no dashboard
- [ ] Implementar busca e filtros
- [ ] Adicionar paginação nas tabelas
- [ ] Exportar relatórios (PDF/Excel)
- [ ] Notificações em tempo real
- [ ] Sistema de perfis de usuário

## 📧 Suporte

Em caso de problemas:
1. Execute `clean.bat`
2. Execute `run.bat`
3. Acesse http://localhost:9090/sge/login

---
**EduGestão** © 2024 - Sistema de Gestão Escolar
