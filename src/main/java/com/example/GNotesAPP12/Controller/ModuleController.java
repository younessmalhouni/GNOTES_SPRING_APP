package com.example.GNotesAPP12.Controller;
import com.example.GNotesAPP12.Model.Module;
import com.example.GNotesAPP12.Service.FilliereService;
import com.example.GNotesAPP12.Service.ModuleService;
import com.example.GNotesAPP12.Service.SemestreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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

    // Display list of professors
    @GetMapping
    public String listModule(Model model) {
        List<Module> modules = moduleService.getAllModules();
        model.addAttribute("modules", modules);
        return "module-list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("module", new Module());
        model.addAttribute("fillieres", filliereService.getAllFillieres());
        model.addAttribute("semestres", semestreService.getAllSemestres());
        return "module-form";
    }
    @PostMapping("/save")
    public String savemodule(@ModelAttribute Module module) {
        moduleService.saveModule(module);
        return "redirect:/modules";
    }

    // Show form for editing a professor
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") String id, Model model) {
        Module module = moduleService.getModuleById(id);
        model.addAttribute("module", module);
        model.addAttribute("fillieres", filliereService.getAllFillieres());
        model.addAttribute("semestres", semestreService.getAllSemestres());
        return "module-form";
    }

    // Handle deleting a professor
    @GetMapping("/delete/{id}")
    public String deletemodule(@PathVariable("id") String id) {
        moduleService.deleteModule(id);
        return "redirect:/modules";
    }
}
