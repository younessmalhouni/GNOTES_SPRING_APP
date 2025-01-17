package com.example.GNotesAPP12.Controller;

import com.example.GNotesAPP12.Model.Etudiant;
import com.example.GNotesAPP12.Service.EtudiantService;
import com.example.GNotesAPP12.Service.FilliereService;
import com.example.GNotesAPP12.Service.SemestreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Base64;
import java.util.List;

@Controller
@RequestMapping("/etudiants")
public class EtudiantController {

    @Autowired
    private EtudiantService etudiantService;
    @Autowired
    private FilliereService filliereService;
    @Autowired
    private SemestreService semestreService;

    @GetMapping
    public String listEtudiants(Model model, @RequestParam(required = false) String search,
                                @RequestParam(required = false) Long filliereId, @RequestParam(required = false) Long semestreId) {
        List<Etudiant> Etudiants = etudiantService.searchEtudiants(search, filliereId, semestreId);
        model.addAttribute("etudiants", Etudiants);
        model.addAttribute("fillieres", filliereService.getAllFillieres());
        model.addAttribute("semestres", semestreService.getAllSemestres());

        return "etudiants-list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("etudiant", new Etudiant());
        model.addAttribute("fillieres", filliereService.getAllFillieres());
        model.addAttribute("semestres", semestreService.getAllSemestres());
        return "etudiant-form";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") String id, Model model) {
        Etudiant etudiant = etudiantService.getEtudiantByCode(id);
        model.addAttribute("etudiant", etudiant);
        model.addAttribute("fillieres", filliereService.getAllFillieres());
        model.addAttribute("semestres", semestreService.getAllSemestres());
        return "etudiant-form";
    }

    @GetMapping("/delete/{id}")
    public String deleteEtudiant(@PathVariable("id") String id) {
        etudiantService.deleteEtudiant(id);
        return "redirect:/etudiants";
    }

    @PostMapping("/save")
    public String saveEtudiant(@ModelAttribute Etudiant etudiant, @RequestParam("imageFile") MultipartFile imageFile) throws IOException {
        if (etudiant.getCodeEtudiant() != null) {
            // Retrieve the existing Etudiant from the database
            Etudiant existingEtudiant = etudiantService.getEtudiantByCode(etudiant.getCodeEtudiant().toString());
            if (existingEtudiant != null) {
                // If the image file is empty, retain the existing image
                if (imageFile.isEmpty()) {
                    etudiant.setImage(existingEtudiant.getImage());
                } else {
                    // Convert the new image to Base64
                    byte[] imageBytes = imageFile.getBytes();
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    etudiant.setImage("data:image/" + imageFile.getContentType().split("/")[1] + ";base64," + base64Image);
                }
            }
        } else {
            // Convert the new image to Base64
            byte[] imageBytes = imageFile.getBytes();
            String base64Image = Base64.getEncoder().encodeToString(imageBytes);
            etudiant.setImage("data:image/" + imageFile.getContentType().split("/")[1] + ";base64," + base64Image);
        }

        etudiantService.saveEtudiant(etudiant);
        return "redirect:/etudiants";
    }

    @GetMapping("/search")
    @ResponseBody
    public List<Etudiant> searchEtudiants(
            @RequestParam(required = false) String search,
            @RequestParam(required = false) Long filliereId,
            @RequestParam(required = false) Long semestreId) {
        return etudiantService.searchEtudiants(search, filliereId, semestreId);
    }
}
