package mg.itu.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import mg.itu.model.Patient;

public class PatientRepository {

    private JdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private static final String COLONNES =
            "id, nom, prenom, date_naissance, sexe, adresse, telephone, email";

    private static final RowMapper<Patient> PATIENT_ROW_MAPPER = new RowMapper<Patient>() {
        @Override
        public Patient mapRow(ResultSet rs, int rowNum) throws SQLException {
            return new Patient(
                    rs.getInt("id"),
                    rs.getString("nom"),
                    rs.getString("prenom"),
                    rs.getString("date_naissance"),   // DATE -> "1990-05-12"
                    rs.getString("sexe"),
                    rs.getString("adresse"),
                    rs.getString("telephone"),
                    rs.getString("email"));
        }
    };

    public List<Patient> findAll() {
        return jdbcTemplate.query("SELECT " + COLONNES + " FROM patient ORDER BY id", PATIENT_ROW_MAPPER);
    }

    public Patient findById(int id) {
        List<Patient> liste = jdbcTemplate.query(
                "SELECT " + COLONNES + " FROM patient WHERE id = ?", PATIENT_ROW_MAPPER, id);
        return liste.isEmpty() ? null : liste.get(0);
    }

    public void insert(Patient p) {
        jdbcTemplate.update(
                "INSERT INTO patient (nom, prenom, date_naissance, sexe, adresse, telephone, email) "
                        + "VALUES (?, ?, CAST(NULLIF(?, '') AS DATE), NULLIF(?, ''), ?, ?, ?)",
                p.getNom(), p.getPrenom(), p.getDateNaissance(), p.getSexe(),
                p.getAdresse(), p.getTelephone(), p.getEmail());
    }

    public void update(Patient p) {
        jdbcTemplate.update(
                "UPDATE patient SET nom = ?, prenom = ?, date_naissance = CAST(NULLIF(?, '') AS DATE), "
                        + "sexe = NULLIF(?, ''), adresse = ?, telephone = ?, email = ? WHERE id = ?",
                p.getNom(), p.getPrenom(), p.getDateNaissance(), p.getSexe(),
                p.getAdresse(), p.getTelephone(), p.getEmail(), p.getId());
    }

    public void deleteById(int id) {
        jdbcTemplate.update("DELETE FROM patient WHERE id = ?", id);
    }
}