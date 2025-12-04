package com.sge.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * Classe utilitária para criptografia de senhas
 * 
 * NOTA: Esta é uma implementação básica com SHA-256.
 * Para produção, recomenda-se usar BCrypt ou PBKDF2
 * que são algoritmos mais robustos com salt automático.
 */
public class PasswordUtil {

    /**
     * Gera hash SHA-256 de uma senha
     * 
     * @param senha Senha em texto plano
     * @return Hash da senha em Base64
     */
    public static String hashSenha(String senha) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(senha.getBytes(StandardCharsets.UTF_8));
            return Base64.getEncoder().encodeToString(hash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Erro ao gerar hash da senha", e);
        }
    }

    /**
     * Verifica se uma senha corresponde ao hash
     * 
     * @param senha Senha em texto plano
     * @param hash Hash armazenado no banco
     * @return true se a senha está correta
     */
    public static boolean verificarSenha(String senha, String hash) {
        String senhaHash = hashSenha(senha);
        return senhaHash.equals(hash);
    }

    /**
     * Gera um salt aleatório
     * 
     * @return Salt em Base64
     */
    public static String gerarSalt() {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[16];
        random.nextBytes(salt);
        return Base64.getEncoder().encodeToString(salt);
    }

    /**
     * Gera hash com salt
     * 
     * @param senha Senha em texto plano
     * @param salt Salt para adicionar segurança
     * @return Hash da senha com salt
     */
    public static String hashComSalt(String senha, String salt) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            String senhaComSalt = senha + salt;
            byte[] hash = digest.digest(senhaComSalt.getBytes(StandardCharsets.UTF_8));
            return Base64.getEncoder().encodeToString(hash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Erro ao gerar hash da senha", e);
        }
    }

    /**
     * Verifica senha com salt
     * 
     * @param senha Senha em texto plano
     * @param hash Hash armazenado
     * @param salt Salt usado
     * @return true se a senha está correta
     */
    public static boolean verificarSenhaComSalt(String senha, String hash, String salt) {
        String senhaHash = hashComSalt(senha, salt);
        return senhaHash.equals(hash);
    }

    /**
     * Valida força da senha
     * 
     * @param senha Senha a validar
     * @return true se a senha é forte
     */
    public static boolean senhaForte(String senha) {
        if (senha == null || senha.length() < 8) {
            return false;
        }

        boolean temMaiuscula = false;
        boolean temMinuscula = false;
        boolean temNumero = false;
        boolean temEspecial = false;

        for (char c : senha.toCharArray()) {
            if (Character.isUpperCase(c)) temMaiuscula = true;
            else if (Character.isLowerCase(c)) temMinuscula = true;
            else if (Character.isDigit(c)) temNumero = true;
            else temEspecial = true;
        }

        return temMaiuscula && temMinuscula && temNumero && temEspecial;
    }

    /**
     * Retorna mensagem sobre a força da senha
     * 
     * @param senha Senha a avaliar
     * @return Mensagem descritiva
     */
    public static String avaliarSenha(String senha) {
        if (senha == null || senha.isEmpty()) {
            return "Senha não pode estar vazia";
        }
        if (senha.length() < 6) {
            return "Senha muito curta (mínimo 6 caracteres)";
        }
        if (senha.length() < 8) {
            return "Senha fraca (recomendado 8+ caracteres)";
        }
        if (!senhaForte(senha)) {
            return "Senha média (adicione maiúsculas, números e caracteres especiais)";
        }
        return "Senha forte";
    }
}
