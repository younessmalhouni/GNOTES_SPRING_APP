package com.example.GNotesAPP12.Controller;

import com.example.GNotesAPP12.Model.Professeur;
import com.example.GNotesAPP12.Service.ProfesseurService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/professeurs")
public class ProfesseurController {

    @Autowired
    private ProfesseurService professeurService;

    // Display list of professors
    @GetMapping
    public String listProfessors(Model model) {
        List<Professeur> professeurs = professeurService.getAllProfesseurs();
        model.addAttribute("professeurs", professeurs);
        return "professeur-list";
    }

    // Show form for adding a professor
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("professeur", new Professeur());
        return "professeur-form";
    }

    // Handle adding a professor
    @PostMapping("/save")
    public String saveProfesseur(@ModelAttribute Professeur professeur) {
        professeurService.saveProfesseur(professeur);
        return "redirect:/professeurs";
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
}
