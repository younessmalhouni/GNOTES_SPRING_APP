package com.example.GNotesAPP12.Controller;
import com.example.GNotesAPP12.Model.Compte;
import com.example.GNotesAPP12.Model.Professeur;
import com.example.GNotesAPP12.Model.Utilisateur;
import com.example.GNotesAPP12.Service.AdministrateurService;
import com.example.GNotesAPP12.Service.CompteService;
import com.example.GNotesAPP12.Service.ProfesseurService;
import com.example.GNotesAPP12.Service.UtilisateurService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/utilisateur")
public class UtilisateurController {

    @Autowired
    private CompteService compteService;

    @Autowired
    private UtilisateurService utilisateurService;
    @Autowired
    private ProfesseurService professeurService;

    @Autowired
    private AdministrateurService administrateurService;

    @GetMapping("/loginPage")
    public String loginPage() {
        return "login";
    }
    @PostMapping("/loginUser")
    public String loginUser(@ModelAttribute("form") Compte compte, Model model, HttpSession session) {
        Compte existingUser = compteService.login(compte.getNomUtilisateur(), compte.getMotDePasse());
        if (existingUser == null) {
            model.addAttribute("msg", "Invalid Login and Password");
            return "login";
        } else {
            session.setAttribute("loggedInUser", existingUser);
            model.addAttribute("nomUtilisateur", existingUser.getNomUtilisateur());
            Integer totalEtudiants = administrateurService.NbreEtudiants();
            Integer totalProfesseurs = administrateurService.NbreProfesseurs();
            Integer totalFillieres = administrateurService.NbreFillieres();
            Integer totalModules = administrateurService.NbreModules();
            model.addAttribute("totalEtudiants", totalEtudiants);
            model.addAttribute("totalProfesseurs", totalProfesseurs);
            model.addAttribute("totalFillieres", totalFillieres);
            model.addAttribute("totalModules", totalModules);
            if (Boolean.TRUE.equals(existingUser.getIsAdmin())) {
                return "adminTemplate"; // Admin-specific JSP
            } else if (Boolean.TRUE.equals(existingUser.getIsProfesseur())) {
                return "professorTemplate"; // Professor-specific JSP
            }
            else {
                model.addAttribute("msg", "User role not recognized.");
                return "login";
            }
        }
    }


    @GetMapping("/profile")
    public String getProfile(Model model, HttpSession session) {
        // Assuming logged-in user's Utilisateur object is stored in session
        Compte compte = (Compte) session.getAttribute("loggedInUser");
        Utilisateur user = compte.getUtilisateur();

        if (user == null) {
            return "redirect:/utilisateur/loginPage"; // Redirect if user not found
        }

        model.addAttribute("utilisateur", user);
        model.addAttribute("compte", compte);
        model.addAttribute("role", user instanceof Professeur ? "Professor" : "Admin");
        model.addAttribute("specialite", user instanceof Professeur ? ((Professeur) user).getSpecialite() : "N/A");

        return "profile";
    }



    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/utilisateur/loginPage";
    }

    @GetMapping("/CreerCompte/{code}")
    public String CreerCompte(@PathVariable("code") Long code, Model model) {
        Professeur professeur = professeurService.getProfesseurById(code.toString());
        Utilisateur utilisateur = utilisateurService.getUtilisateurByCode(code);
        model.addAttribute("professeur", professeur);
        model.addAttribute("utilisateur", utilisateur);

        model.addAttribute("compte", new Compte());
        return "Creer-Compte";
    }

    @PostMapping("/saveCompte/{code}")
    public String saveCompte(@PathVariable("code") Long code,@ModelAttribute("compte") Compte compte) {

        Utilisateur utilisateur = utilisateurService.getUtilisateurByCode(code);
        compte.setUtilisateur(utilisateur);
        compteService.saveCompte(compte);
        return "redirect:/professeurs";
    }

    @GetMapping("/getByCode/{code}")
    @ResponseBody
    public Utilisateur getUtilisateurByCode(@PathVariable Long code) {
        return utilisateurService.getUtilisateurByCode(code);
    }


}
