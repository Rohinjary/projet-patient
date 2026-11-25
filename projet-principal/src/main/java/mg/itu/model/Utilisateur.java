package mg.itu.model;

public class Utilisateur {

    private int id;
    private String login;
    private String role;        // "medecin" ou "patient"
    private int patientId;      // 0 si medecin

    public Utilisateur() {}

    public Utilisateur(int id, String login, String role, int patientId) {
        this.id = id;
        this.login = login;
        this.role = role;
        this.patientId = patientId;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getLogin() { return login; }
    public void setLogin(String login) { this.login = login; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public int getPatientId() { return patientId; }
    public void setPatientId(int patientId) { this.patientId = patientId; }
}