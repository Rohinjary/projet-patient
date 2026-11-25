package mg.itu.service;

import java.util.List;

import mg.itu.model.Patient;
import mg.itu.repository.PatientRepository;

public class PatientService {

    private PatientRepository patientRepository;

    public void setPatientRepository(PatientRepository patientRepository) {
        this.patientRepository = patientRepository;
    }

    public List<Patient> listerTout() {
        return patientRepository.findAll();
    }

    public Patient trouver(int id) {
        return patientRepository.findById(id);
    }

    public void enregistrer(Patient p) {
        nettoyer(p);
        if (p.getId() == 0) {
            patientRepository.insert(p);
        } else {
            patientRepository.update(p);
        }
    }

    public void supprimer(int id) {
        patientRepository.deleteById(id);
    }

    // jamais de null (un champ absent du formulaire) ni d'espaces en trop
    private void nettoyer(Patient p) {
        p.setNom(n(p.getNom()));
        p.setPrenom(n(p.getPrenom()));
        p.setDateNaissance(n(p.getDateNaissance()));
        p.setSexe(n(p.getSexe()));
        p.setAdresse(n(p.getAdresse()));
        p.setTelephone(n(p.getTelephone()));
        p.setEmail(n(p.getEmail()));
    }

    private String n(String s) {
        return s == null ? "" : s.trim();
    }
}