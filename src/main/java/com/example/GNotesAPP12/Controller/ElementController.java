package com.example.GNotesAPP12.Controller;


import com.example.GNotesAPP12.Model.Element;
import com.example.GNotesAPP12.Model.Modalite_Evaluation;
import com.example.GNotesAPP12.Model.Module;
import com.example.GNotesAPP12.Model.Professeur;
import com.example.GNotesAPP12.Service.ElementService;
import com.example.GNotesAPP12.Service.ModuleService;
import com.example.GNotesAPP12.Service.ProfesseurService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/elements")
public class ElementController {

    @Autowired
    private ElementService elementService;
    @Autowired
    private ProfesseurService professeurService;
    @Autowired
    private ModuleService moduleService;


    @GetMapping
    public String elements(
            @RequestParam(required = false, defaultValue = "") String moduleId,
            @RequestParam(required = false, defaultValue = "") String profId,
            @RequestParam(required = false, defaultValue = "") String searchTerm,
            Model model
    ) {
        List<Element> elements = elementService.SearchElements(moduleId, profId, searchTerm);
        model.addAttribute("elements", elements);
        model.addAttribute("professeurs", professeurService.getAllProfesseurs());
        model.addAttribute("modules", moduleService.getAllModules());
        model.addAttribute("selectedModule", moduleId);
        model.addAttribute("selectedProf", profId);
        model.addAttribute("searchTerm", searchTerm);
        return "element-list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("element", new Element());
        model.addAttribute("professeurs", professeurService.getAllProfesseurs());
        model.addAttribute("modules", moduleService.getAllModules());
        return "element-form";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") String id, Model model) {
        Element element = elementService.getElementById(id);
        model.addAttribute("element", element);
        model.addAttribute("professeurs", professeurService.getAllProfesseurs());
        model.addAttribute("modules", moduleService.getAllModules());
        return "element-form";
    }

    @GetMapping("/delete/{id}")
    public String deleteElement(@PathVariable("id") String id) {
        elementService.deleteElement(id);
        return "redirect:/elements";
    }

    @Transactional
    @PostMapping("/save")
    public String saveElement(Element element) {
        try {
            // Vérifier et charger le module
            if (element.getModule() != null && element.getModule().getCodeModule() != null) {
                Module existingModule = moduleService.getModuleById(element.getModule().getCodeModule().toString());
                if (existingModule == null) {
                    throw new RuntimeException("Module not found");
                }
                element.setModule(existingModule);
            }

            // Vérifier et charger le professeur
            if (element.getProfesseur() != null && element.getProfesseur().getCode() != null) {
                Professeur existingProf = professeurService.getProfesseurById(element.getProfesseur().getCode().toString());
                if (existingProf == null) {
                    throw new RuntimeException("Professeur not found");
                }
                element.setProfesseur(existingProf);
            }

            // Gérer les modalités d'évaluation si elles existent
            if (element.getModalites() != null) {
                for (Modalite_Evaluation modalite : element.getModalites()) {
                    modalite.setElement(element);
                }
            }

            // Sauvegarder l'élément
            elementService.saveElement(element);
            return "redirect:/elements";
        } catch (Exception e) {
            // Log l'erreur et rediriger vers une page d'erreur ou le formulaire avec un message
            e.printStackTrace();
            return "redirect:/elements/add?error=true";
        }
    }

    @GetMapping("/Details/{id}")
    public String DetailsElements(@PathVariable("id") String id, Model model) {
        Element element = elementService.getElementById(id);
        model.addAttribute("element", element);
        model.addAttribute("modalites", element.getModalites());
        return "element-details";
    }

}
