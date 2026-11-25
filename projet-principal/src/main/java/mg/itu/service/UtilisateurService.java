package mg.itu.service;

import mg.itu.model.Utilisateur;
import mg.itu.repository.UtilisateurRepository;

public class UtilisateurService {

    private UtilisateurRepository utilisateurRepository;

    public void setUtilisateurRepository(UtilisateurRepository utilisateurRepository) {
        this.utilisateurRepository = utilisateurRepository;
    }


    public Utilisateur authentifier(String login, String motDePasse) {
        if (login == null || motDePasse == null) {
            return null;
        }
        return utilisateurRepository.findByLoginEtMotDePasse(login.trim(), motDePasse);
    }
}