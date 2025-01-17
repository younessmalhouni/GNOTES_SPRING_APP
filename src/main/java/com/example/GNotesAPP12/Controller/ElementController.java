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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        Module module = element.getModule();
        Double sommeCoefModule = moduleService.SommeCoefModule(module.getCodeModule());
        model.addAttribute("sommeCoefModule", sommeCoefModule);
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
    public String saveElement(Element element, Model model) {
        try {
            // Get current sum of coefficients for the module
            Double sommeCoefModule = moduleService.SommeCoefModule(element.getModule().getCodeModule());

            // Check if this is an edit (element exists) or new element
            Double AncienCoefficient = 0.0;
            if (element.getIdElement() != null) {  // If element has ID, it's an edit
                Element AncienElement = elementService.ElementExistant(element.getIdElement());
                if (AncienElement != null) {
                    AncienCoefficient = AncienElement.getCoefficient();
                }
            }

            // Adjust total by subtracting old coefficient and adding new one
            double TotalCoef = sommeCoefModule - AncienCoefficient + element.getCoefficient();

            if (element.getModule() != null && element.getModule().getCodeModule() != null) {
                Module module = moduleService.getModuleById(element.getModule().getCodeModule().toString());
                element.setModule(module);
            }

            if (element.getProfesseur() != null && element.getProfesseur().getCode() != null) {
                Professeur professeur = professeurService.getProfesseurById(element.getProfesseur().getCode().toString());
                element.setProfesseur(professeur);
            }

            if (element.getModalites() != null) {
                for (Modalite_Evaluation modalite : element.getModalites()) {
                    modalite.setElement(element);
                }
            }

            if (TotalCoef <= 100) {
                elementService.saveElement(element);
                return "redirect:/elements";
            } else {
                model.addAttribute("errorMessage", "La somme des coefficients des éléments du module ne peut pas dépasser 100");
                model.addAttribute("element", element);
                model.addAttribute("professeurs", professeurService.getAllProfesseurs());
                model.addAttribute("modules", moduleService.getAllModules());
                return "element-form";
            }
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Une erreur s'est produite lors de l'enregistrement: " + e.getMessage());
            model.addAttribute("element", element);
            model.addAttribute("professeurs", professeurService.getAllProfesseurs());
            model.addAttribute("modules", moduleService.getAllModules());
            return "element-form";
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
