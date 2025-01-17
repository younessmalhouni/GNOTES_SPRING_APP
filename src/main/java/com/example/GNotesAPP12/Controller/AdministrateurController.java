package com.example.GNotesAPP12.Controller;

import com.example.GNotesAPP12.Model.Professeur;
import com.example.GNotesAPP12.Service.ProfesseurService;
import com.example.GNotesAPP12.Service.UtilisateurService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Base64;
import java.util.List;

@Controller
@RequestMapping("/professeurs")
public class AdministrateurController {

    @Autowired
    private ProfesseurService professeurService;

    @Autowired
    private UtilisateurService utilisateurService;

    // Display list of professors
    @GetMapping
    public String listProfessors(Model model) {
        List<Professeur> professeurs = professeurService.getAllProfesseurs();
        model.addAttribute("professeurs", professeurs);
        model.addAttribute("specialites", professeurService.getAllSpecialities());
        model.addAttribute("utilisateurService", utilisateurService);

        return "professeur-list";
    }

    // Show form for adding a professor
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("professeur", new Professeur());
        return "professeur-form";
    }

    @PostMapping("/save")
    public String saveProfesseur(@ModelAttribute("professeur") Professeur professeur,
                                 @RequestParam(value = "imageFile", required = false) MultipartFile imageFile)
            throws IOException {

        if (professeur.getCode() != null) {
            // Get existing professor
            Professeur existingProfesseur = professeurService.getProfesseurById(professeur.getCode().toString());
            if (existingProfesseur != null) {
                // Preserve existing image if no new image is uploaded
                if (imageFile == null || imageFile.isEmpty()) {
                    professeur.setImage(existingProfesseur.getImage());
                } else {
                    processAndSetImage(professeur, imageFile);
                }
            }
        } else if (imageFile != null && !imageFile.isEmpty()) {
            processAndSetImage(professeur, imageFile);
        }
        professeurService.saveProfesseur(professeur);
        return "redirect:/professeurs";
    }

    private void processAndSetImage(Professeur professeur, MultipartFile imageFile) throws IOException {
        byte[] imageBytes = imageFile.getBytes();
        String base64Image = Base64.getEncoder().encodeToString(imageBytes);
        String contentType = imageFile.getContentType();
        if (contentType == null) {
            contentType = "image/jpeg";
        }
        professeur.setImage("data:" + contentType + ";base64," + base64Image);
    }
    // Show form for editing a professor
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") String id, Model model) {
        Professeur professeur = professeurService.getProfesseurById(id);
        model.addAttribute("professeur", professeur);
        return "professeur-form";
    }

    // Handle deleting a professor
    @GetMapping("/delete/{id}")
    public String deleteProfesseur(@PathVariable("id") String id) {
        professeurService.deleteProfesseur(id);
        return "redirect:/professeurs";
    }

    @GetMapping("/search")
    @ResponseBody
    public List<Professeur> searchProfesseurs(
            @RequestParam(required = false) String searchTerm,
            @RequestParam(required = false) String specialite) {
        return professeurService.searchProfesseurs(searchTerm, specialite);
    }
}
