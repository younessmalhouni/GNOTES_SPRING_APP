package com.example.GNotesAPP12.Controller;
import com.example.GNotesAPP12.Model.Professeur;
import com.example.GNotesAPP12.Model.Utilisateur;
import com.example.GNotesAPP12.Service.UtilisateurService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/utilisateur")
public class UtilisateurController {

    @Autowired
    private UtilisateurService utilisateurService;

    @GetMapping("/loginPage")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/loginUser")
    public String loginUser(@ModelAttribute("form") Utilisateur user, Model model, HttpSession session) {
        Utilisateur existingUser = utilisateurService.login(user.getNomUtilisateur(), user.getMotDePasse());

        if (existingUser == null) {
            model.addAttribute("msg", "Invalid Login and Password");
            return "login";
        } else {
            session.setAttribute("loggedInUser", existingUser);
            model.addAttribute("nomUtilisateur", existingUser.getNomUtilisateur());

            if (Boolean.TRUE.equals(existingUser.getIsAdmin())) {
                return "adminTemplate"; // Admin-specific JSP
            } else if (Boolean.TRUE.equals(existingUser.getIsProfesseur())) {
                return "professorTemplate"; // Professor-specific JSP
            } else if (Boolean.TRUE.equals(existingUser.getIsAdmin()) && Boolean.TRUE.equals(existingUser.getIsProfesseur())) {
                return "adminProfessorTemplate"; // Admin and Professor-specific JSP

            }
            else {
                model.addAttribute("msg", "User role not recognized.");
                return "login";
            }
        }
    }


    @GetMapping("/profile")
    public String getProfile(Model model, HttpSession session) {
        // Assuming logged-in user's username is stored in session (e.g., using Spring Security)
        String username = (String) session.getAttribute("loggedInUser");

        Utilisateur user = utilisateurService.findByNomUtilisateur(username);

        if (user == null) {
            return "redirect:/utilisateur/loginPage"; // Redirect if user not found
        }

        model.addAttribute("utilisateur", user);
        model.addAttribute("role", user instanceof Professeur ? "Professor" : "Admin");
        model.addAttribute("specialite", user instanceof Professeur ? ((Professeur) user).getSpecialite() : "N/A");

        return "profile";
    }


}
