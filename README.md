# Guia de Configuração: Firebase para Autenticação

## 🔥 O que é o Firebase?

O **Firebase Authentication** é uma ferramenta poderosa para gerenciar autenticações de usuários em aplicativos. Neste guia, você aprenderá como configurar e integrar o Firebase ao seu aplicativo para permitir **login**, **logout** e **cadastro de usuários**.

---

## 🛠️ Como Configurar o Firebase no Seu Projeto

### 1️⃣ **Criar um Projeto no Firebase**

1. Acesse o [Firebase Console](https://console.firebase.google.com/).
2. Clique em **Adicionar Projeto**.
3. Dê um nome ao seu projeto e conclua as etapas da criação.

---

### 2️⃣ **Ativar o Firebase Authentication**

1. No painel do Firebase, clique em **Authentication** no menu lateral.
2. Acesse a aba **Métodos de Login**.
3. Ative a opção **Email e Senha**.

---

### 3️⃣ **Adicionar o Firebase ao Seu Projeto**

#### **Para Android**
1. No Firebase Console, clique em **Adicionar App** e selecione Android.
2. Insira o nome do pacote do seu aplicativo (ex.: `com.seuprojeto.app`).
3. Faça o download do arquivo **google-services.json**.
4. Adicione o arquivo na pasta `android/app/` do seu projeto.

#### **Para iOS**
1. No Firebase Console, clique em **Adicionar App** e selecione iOS.
2. Insira o nome do pacote (Bundle ID) do seu aplicativo (ex.: `com.seuprojeto.app`).
3. Faça o download do arquivo **GoogleService-Info.plist**.
4. Adicione o arquivo na pasta `ios/Runner/`.

---

### 4️⃣ **Configurar no Flutter**

1. Instale os pacotes necessários no seu projeto (Firebase Core e Firebase Auth).
2. Inicialize o Firebase no método `main()` do seu aplicativo.

---

## 🌟 Funcionalidades Habilitadas

Após configurar o Firebase, seu aplicativo poderá:

- **Cadastrar Usuários:** Registrar novos usuários com email e senha.
- **Fazer Login:** Autenticar usuários registrados.
- **Realizar Logout:** Encerrar a sessão ativa de um usuário.

---

🎉 **Tudo pronto!** Agora você pode implementar as funcionalidades de autenticação no seu aplicativo Flutter. 🚀
