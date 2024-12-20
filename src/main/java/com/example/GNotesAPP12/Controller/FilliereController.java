package com.example.GNotesAPP12.Controller;
import com.example.GNotesAPP12.Model.Filliere;
import com.example.GNotesAPP12.Service.FilliereService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/fillieres")
public class FilliereController {

    @Autowired
    private FilliereService filliereService;

    // Display list of professors
    @GetMapping
    public String listFilliere(Model model) {
        List<Filliere> fillieres = filliereService.getAllFillieres();
        model.addAttribute("fillieres", fillieres);
        return "filliere-list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("filliere", new Filliere());
        return "filliere-form";
    }
    @PostMapping("/save")
    public String savefilliere(@ModelAttribute Filliere filliere) {
        filliereService.saveFilliere(filliere);
        return "redirect:/fillieres";
    }

    // Show form for editing a professor
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") String id, Model model) {
        Filliere filliere = filliereService.getFilliereById(id);
        model.addAttribute("filliere", filliere);
        return "filliere-form";
    }

    // Handle deleting a professor
    @GetMapping("/delete/{id}")
    public String deletefilliere(@PathVariable("id") String id) {
        filliereService.deleteFilliere(id);
        return "redirect:/fillieres";
    }
}

