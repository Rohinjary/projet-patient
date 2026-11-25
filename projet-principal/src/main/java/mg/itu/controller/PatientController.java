package mg.itu.controller;

import java.util.List;

import org.springframework.context.ApplicationContext;

import mg.itu.annotation.Auth;
import mg.itu.annotation.Controller;
import mg.itu.annotation.ResponseBody;
import mg.itu.annotation.UrlMapping;
import mg.itu.model.Patient;
import mg.itu.service.PatientService;
import mg.itu.session.Session;
import mg.itu.view.ModelAndView;

@Controller
public class PatientController {

    // ---------- API JSON (sera appelee par le programme autonome au Sprint 2) ----------
    @UrlMapping(value = "/api/patient/list", method = "GET")
    @ResponseBody
    public List<Patient> getAll(ApplicationContext springContext) {
        return service(springContext).listerTout();
    }

    @Auth(role = "medecin")
    @UrlMapping(value = "/patient/list", method = "GET")
    public ModelAndView liste(ApplicationContext springContext) {
        ModelAndView mv = new ModelAndView("patient/liste");
        mv.setAttribute("listePatient", service(springContext).listerTout());
        return mv;
    }

    @Auth(role = "medecin")
    @UrlMapping(value = "/patient/form", method = "GET")
    public ModelAndView formulaire(ApplicationContext springContext, int id) {
        Patient patient = null;
        if (id > 0) {
            patient = service(springContext).trouver(id);
        }
        if (patient == null) {
            patient = new Patient();
        }
        ModelAndView mv = new ModelAndView("patient/form");
        mv.setAttribute("patient", patient);
        return mv;
    }

    @Auth(role = "medecin")
    @UrlMapping(value = "/patient/save", method = "POST")
    public ModelAndView enregistrer(ApplicationContext springContext, Patient patient) {
        service(springContext).enregistrer(patient);
        return new ModelAndView("redirect:/patient/list");
    }

    // ---------- supprimer ----------
    @Auth(role = "medecin")
    @UrlMapping(value = "/patient/delete", method = "POST")
    public ModelAndView supprimer(ApplicationContext springContext, int id) {
        service(springContext).supprimer(id);
        return new ModelAndView("redirect:/patient/list");
    }

    @Auth(role = {"medecin", "patient"})
    @UrlMapping(value = "/patient/fiche", method = "GET")
    public ModelAndView fiche(ApplicationContext springContext, Session session, int id) {

        String role = (String) session.get("role_utilisateur");

        if ("patient".equals(role)) {
            id = (Integer) session.get("patient_id");
        }

        Patient patient = service(springContext).trouver(id);
        if (patient == null) {
            return new ModelAndView("redirect:/patient/list");
        }

        ModelAndView mv = new ModelAndView("patient/fiche");
        mv.setAttribute("patient", patient);
        return mv;
    }

    private PatientService service(ApplicationContext springContext) {
        return (PatientService) springContext.getBean("patientService");
    }
}