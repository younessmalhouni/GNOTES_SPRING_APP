package com.example.GNotesAPP12.Controller;

import com.example.GNotesAPP12.Model.Element;
import com.example.GNotesAPP12.Model.Modalite_Evaluation;
import com.example.GNotesAPP12.Model.Module;
import com.example.GNotesAPP12.Repo.NoteElementRepo;
import com.example.GNotesAPP12.Service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/modules")
public class ModuleController {

    @Autowired
    private ModuleService moduleService;

    @Autowired
    private FilliereService filliereService;

    @Autowired
    private SemestreService semestreService;

    @Autowired
    private ElementService elementService;
    @Autowired
    private ProfesseurService professeurService;
    @Autowired
    private NoteElementService noteElementService;

    @GetMapping
    public String listModule(Model model) {
        List<Module> modules = moduleService.getAllModules();
        model.addAttribute("modules", modules);
        return "module-list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        Module module = new Module();
        module.setElements(new ArrayList<>());
        model.addAttribute("module", module);
        model.addAttribute("fillieres", filliereService.getAllFillieres());
        model.addAttribute("semestres", semestreService.getAllSemestres());
        model.addAttribute("professeurs", professeurService.getAllProfesseurs());
        return "module-form";
    }

    @Transactional
    @PostMapping("/save")
    public String saveModule(@ModelAttribute Module module) {
        if (module.getElements() == null) {
            module.setElements(new ArrayList<>());}
        for (Element element : module.getElements()) {
            element.setModule(module);
            if (element.getProfesseur() != null) {
                element.setProfesseur(professeurService.getProfesseurById(element.getProfesseur().getCode().toString()));
            }
            if (element.getModalites() == null) {
                element.setModalites(new ArrayList<>());
            }
            if (element.getNoteElements() == null) {
                element.setNoteElements(new ArrayList<>());
            }

            for (Modalite_Evaluation modalite : element.getModalites()) {
                modalite.setElement(element);
            }
        }
        moduleService.saveModule(module);
        return "redirect:/modules";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") String id, Model model) {
        Module module = moduleService.getModuleById(id);
        if (module.getElements() == null) {
            module.setElements(new ArrayList<>());
        }
        Double SommeCoefModule = moduleService.SommeCoefModule(module.getCodeModule());
        model.addAttribute("SommeCoefModule", SommeCoefModule);
        model.addAttribute("module", module);
        model.addAttribute("fillieres", filliereService.getAllFillieres());
        model.addAttribute("semestres", semestreService.getAllSemestres());
        model.addAttribute("professeurs", professeurService.getAllProfesseurs());
        return "module-form";
    }

    @GetMapping("/delete/{id}")
    public String deleteModule(@PathVariable("id") String id) {
        moduleService.deleteModule(id);
        return "redirect:/modules";
    }

    @GetMapping("/VoirNotes/{id}")
    public String VoirNotes(@PathVariable("id") String id, Model model,
                            @RequestParam(required = false, defaultValue = "") Long filliereId,
                            @RequestParam(required = false, defaultValue = "") Long semestreId,
                            @RequestParam(required = false, defaultValue = "") String searchTerm
                             ) {
        Module module = moduleService.getModuleById(id);
        model.addAttribute("module", module);
        model.addAttribute("elements", module.getElements());
        model.addAttribute("etudiants", moduleService.EtudiantsOfModule(module.getCodeModule(),semestreId,filliereId , searchTerm));
        model.addAttribute("fillieres", filliereService.getAllFillieres());
        model.addAttribute("semestres", semestreService.getAllSemestres());
        model.addAttribute("moduleService", moduleService);

        model.addAttribute("noteElementService",noteElementService);

        return "module-notes";
    }
}