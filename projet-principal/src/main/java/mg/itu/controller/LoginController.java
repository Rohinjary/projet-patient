package mg.itu.controller;

import org.springframework.context.ApplicationContext;

import mg.itu.annotation.Controller;
import mg.itu.annotation.UrlMapping;
import mg.itu.model.Utilisateur;
import mg.itu.service.UtilisateurService;
import mg.itu.session.Session;
import mg.itu.view.ModelAndView;

@Controller
public class LoginController {

    // affiche le formulaire de connexion
    @UrlMapping(value = "/login", method = "GET")
    public ModelAndView formulaire() {
        return new ModelAndView("login");
    }

    // verifie les identifiants et remplit la session
    // (les cles sont celles declarees dans web.xml : utilisateur_connecte et role_utilisateur)
    @UrlMapping(value = "/login", method = "POST")
    public ModelAndView connecter(ApplicationContext springContext, Session session,
                                  String login, String motDePasse) {

        UtilisateurService service = (UtilisateurService) springContext.getBean("utilisateurService");
        Utilisateur u = service.authentifier(login, motDePasse);

        if (u == null) {
            ModelAndView mv = new ModelAndView("login");
            mv.setAttribute("erreur", "Login ou mot de passe incorrect");
            return mv;
        }

        session.ajouter("utilisateur_connecte", u.getLogin());
        session.ajouter("role_utilisateur", u.getRole());
        session.ajouter("patient_id", u.getPatientId());   // 0 pour le medecin

        if ("medecin".equals(u.getRole())) {
            return new ModelAndView("redirect:/patient/list");
        }
        return new ModelAndView("redirect:/patient/fiche?id=" + u.getPatientId());
    }

    @UrlMapping(value = "/logout", method = "GET")
    public ModelAndView deconnecter(Session session) {
        session.supprimer("utilisateur_connecte");
        session.supprimer("role_utilisateur");
        session.supprimer("patient_id");
        return new ModelAndView("redirect:/login");
    }
}