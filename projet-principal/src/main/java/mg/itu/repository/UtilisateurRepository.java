package mg.itu.repository;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;

import mg.itu.model.Utilisateur;

public class UtilisateurRepository {

    private JdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }


    public Utilisateur findByLoginEtMotDePasse(String login, String motDePasse) {
        List<Utilisateur> liste = jdbcTemplate.query(
                "SELECT id, login, role, patient_id FROM utilisateur WHERE login = ? AND mot_de_passe = ?",
                (rs, n) -> new Utilisateur(
                        rs.getInt("id"),
                        rs.getString("login"),
                        rs.getString("role"),
                        rs.getInt("patient_id")),      // NULL -> 0
                login, motDePasse);
        return liste.isEmpty() ? null : liste.get(0);
    }
}