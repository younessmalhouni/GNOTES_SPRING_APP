package com.example.GNotesAPP12.Controller;

import com.example.GNotesAPP12.Model.*;
import com.example.GNotesAPP12.Model.Module;
import com.example.GNotesAPP12.Service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.nio.file.CopyOption;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/professeur")
public class ProfesseurController {

    @Autowired
    private EtudiantService etudiantService;

    @Autowired
    private ProfesseurService professeurService;

    @Autowired
    private FilliereService filliereService;

    @Autowired
    private SemestreService semestreService;
    @Autowired
    private ModuleService moduleService;
    @Autowired
    private ElementService elementService;
    @Autowired
    private NoteModaliteService noteModaliteService;
    @Autowired
    private Modalite_EvaluationService modalite_evaluationService;
    @Autowired
    private NoteElementService noteElementService;

    @Autowired
    private NoteModuleService noteModuleService;


    @GetMapping("/etudiants")
    public String listEtudiantsProfesseur(Model model, HttpSession session,
                                          @RequestParam(required = false, defaultValue = "") String searchTerm,
                                          @RequestParam(required = false, defaultValue = "") Long filliereId,
                                          @RequestParam(required = false, defaultValue = "") Long semestreId,
                                          @RequestParam(required = false, defaultValue = "") Long codeModule,
                                          @RequestParam(required = false, defaultValue = "") Long idElement) {

        {
            if (idElement!=null){
                Element element = elementService.getElementById(idElement.toString());
                List<Modalite_Evaluation> modalites = modalite_evaluationService.getAllModalite_Evaluations_byElement(element.getIdElement());
                model.addAttribute("modalites", modalites);
                model.addAttribute("element", element);
            }

            model.addAttribute("fillieres", filliereService.getAllFillieres());
            model.addAttribute("semestres", semestreService.getAllSemestres());
            model.addAttribute("modules", moduleService.getAllModules());
            model.addAttribute("elements", elementService.getAllElements());
            model.addAttribute("etudiantService", etudiantService);


            // Récupérer le professeur connecté depuis la session
            Compte Compte = (Compte) session.getAttribute("loggedInUser");
            Professeur professeur = professeurService.getProfesseurById(Compte.getUtilisateur().getCode().toString());

            if (professeur == null) {
                return "redirect:/utilisateur/loginPage";
            }

            // Récupérer uniquement les étudiants associés à ce professeur
            List<Etudiant> etudiantsProfesseur = professeurService.getEtudiantsByProfesseur(professeur.getCode(), searchTerm, filliereId, semestreId, codeModule, idElement);

            model.addAttribute("etudiants", etudiantsProfesseur);
            //model.addAttribute("fillieres", professeur.getFillieres());  // Si le professeur a des filières spécifiques
            return "prof_etudiants-list";
        }
    }

    @GetMapping("/elements")
    public String listElementsProfesseur(Model model, HttpSession session,
                                          @RequestParam(required = false, defaultValue = "") String searchTerm,
                                          @RequestParam(required = false, defaultValue = "") Long filliereId,
                                          @RequestParam(required = false, defaultValue = "") Long semestreId,
                                          @RequestParam(required = false, defaultValue = "") Long codeModule) {

        model.addAttribute("fillieres", filliereService.getAllFillieres());
        model.addAttribute("semestres", semestreService.getAllSemestres());
        model.addAttribute("modules", moduleService.getAllModules());

        // Récupérer le professeur connecté depuis la session
        Compte Compte = (Compte) session.getAttribute("loggedInUser");
        Professeur professeur = professeurService.getProfesseurById(Compte.getUtilisateur().getCode().toString());

        if (professeur == null) {
            return "redirect:/utilisateur/loginPage";
        }

        // Récupérer uniquement les éléments associés à ce professeur
        List<Element> elementsProfesseur = professeurService.getElementsByProfesseur(professeur.getCode(),searchTerm, filliereId, semestreId, codeModule);

        model.addAttribute("elements", elementsProfesseur);
        //model.addAttribute("fillieres", professeur.getFillieres());  // Si le professeur a des filières spécifiques
        return "prof_elements-list";
    }

    @GetMapping("/etudiants/notes/{id}")
    public String listNotesEtudiant(@PathVariable("id") String id, Model model,HttpSession session) {
        Compte compte = (Compte) session.getAttribute("loggedInUser");
        Professeur professeur = professeurService.getProfesseurById(compte.getUtilisateur().getCode().toString());
        Etudiant etudiant = etudiantService.getEtudiantByCode(id);
        model.addAttribute("etudiant", etudiant);
        model.addAttribute("elements",professeurService.ElementsByEtudiantandProfesseur(professeur.getCode(),etudiant.getCodeEtudiant()));
        return "prof_etudiant-notes";
    }

    @GetMapping("/etudiants/notes/{idEtudiant}/{idElement}/ModifierNotes")
    public String modifierNotesEtudiant(@PathVariable("idEtudiant") String idEtudiant,@PathVariable("idElement") String idElement, Model model,HttpSession session) {
        Compte compte = (Compte) session.getAttribute("loggedInUser");
        Professeur professeur = professeurService.getProfesseurById(compte.getUtilisateur().getCode().toString());
        Etudiant etudiant = etudiantService.getEtudiantByCode(idEtudiant);
        Element element = elementService.getElementById(idElement);
        model.addAttribute("etudiant", etudiant);
        model.addAttribute("element", element);
        NoteElement noteElement = element.getNoteElementByEtudiant(etudiant);

        if (noteElement != null) {
            model.addAttribute("noteElement", noteElement);
            if (!noteElement.getIsValide()){
                return "notes_form-modifier";
            }
            else {
                return "redirect:/professeur/etudiants/notes/" + idEtudiant;
            }

        }
    return "notes_form-modifier";
    }

    @GetMapping("/etudiants/notes/{idEtudiant}/{idElement}/Valider")
    public String validerNotesEtudiant(@PathVariable("idEtudiant") String idEtudiant,@PathVariable("idElement") String idElement, Model model,HttpSession session) {
        Compte compte = (Compte) session.getAttribute("loggedInUser");
        Professeur professeur = professeurService.getProfesseurById(compte.getUtilisateur().getCode().toString());
        Etudiant etudiant = etudiantService.getEtudiantByCode(idEtudiant);
        Element element = elementService.getElementById(idElement);
        model.addAttribute("etudiant", etudiant);
        model.addAttribute("element", element);
        NoteElement noteElement = element.getNoteElementByEtudiant(etudiant);

        if (noteElement != null) {
            model.addAttribute("noteElement", noteElement);
            noteElement.setValide(true);
            noteElementService.saveNoteElement(noteElement);
            return "redirect:/professeur/etudiants/notes/" + idEtudiant;
        }
        Module module = element.getModule();
        boolean isElementofModuleValid = noteModuleService.isElementsOfModuleValid(module, etudiant);
        if (isElementofModuleValid==false) {
            NoteModule noteModule = noteModuleService.getNoteModuleByModule_IdAndEtudiant_Id(module.getCodeModule(), etudiant.getCodeEtudiant());

            if (noteModule == null) {
                noteModule = new NoteModule();
                noteModule.setEtudiant(etudiant);
                noteModule.setModule(module);
                noteModule.setNoteModule(noteModuleService.calculateModuleNoteForEtudiant(module, etudiant));
            }
            noteModuleService.saveNoteModule(noteModule);
        }

        return "redirect:/professeur/etudiants/notes/" + idEtudiant;
    }


    @PostMapping("/etudiants/notes/{idEtudiant}/{idElement}/save")
    public String saveNotesEtudiant(
            @PathVariable("idEtudiant") String idEtudiant,
            @PathVariable("idElement") String idElement,
            Model model,
            HttpSession session,
            @RequestParam Map<String, String> allParams) {

        // Get required entities
        model.addAttribute("elements", filliereService.getAllFillieres());
        Etudiant etudiant = etudiantService.getEtudiantByCode(idEtudiant);
        Element element = elementService.getElementById(idElement);
        List<Modalite_Evaluation> modalites = modalite_evaluationService.getAllModalite_Evaluations_byElement(element.getIdElement());

        double Noteelement = 0.0;
        double totalCoefficients=0.0;

        for (Modalite_Evaluation modalite : modalites) {
            String noteKey = "note_" + modalite.getId_Modalite();
            String absentKey = "absent_" + modalite.getId_Modalite();

            // Check if student was marked as absent
            boolean isAbsent = allParams.containsKey(absentKey) && allParams.get(absentKey).equals("on");

            // trouver la note de la modalité pour cet étudiant s'il existe déjà ou créer une nouvelle
            NoteModalite noteModalite = noteModaliteService.getNoteModaliteByModaliteAndEtudiant(modalite.getId_Modalite(), etudiant.getCodeEtudiant());

            if (noteModalite == null) {
                // Create new note if doesn't exist
                noteModalite = new NoteModalite();
                noteModalite.setEtudiant(etudiant);
                noteModalite.setModaliteEvaluation(modalite);
            }

            // Update note values
            if (isAbsent) {
                noteModalite.setAbsent(true);
                noteModalite.setNoteModalite(0.0);
            } else {
                String noteValue = allParams.get(noteKey);
                if (noteValue != null && !noteValue.isEmpty()) {
                    double note = Double.parseDouble(noteValue);
                    noteModalite.setAbsent(false);
                    noteModalite.setNoteModalite(note);

                    // Add to weighted sum for element note calculation
                    Noteelement += note * (modalite.getCoeffecient() / 100.0);
                    totalCoefficients += modalite.getCoeffecient();
                }
            }

            // Save or update note modalité
            noteModaliteService.saveNoteModalite(noteModalite);
        }
        Double ElementNote = noteElementService.CalculerNoteElement(element.getIdElement(), etudiant.getCodeEtudiant());

        // Calculate and save element note
        if (totalCoefficients == 100) {
            // Trouver la note de l'élément pour cet étudiant s'il existe déjà ou créer une nouvelle
            NoteElement noteElement = noteElementService.getNoteElementByElementAndEtudiant(element.getIdElement(), etudiant.getCodeEtudiant());
        if (noteElement == null) {
            noteElement = new NoteElement();
            noteElement.setEtudiant(etudiant);
            noteElement.setElement(element);
            noteElement.setNoteElement(ElementNote);
        }else if(noteElement.getIsValide()==true){
            return "redirect:/professeur/etudiants";

            }
            noteElement.setNoteElement(ElementNote);
            noteElementService.saveNoteElement(noteElement);
        }


        return "redirect:/professeur/etudiants/notes/" + idEtudiant;
    }


    @GetMapping("/etudiants/listAExporter/{idElement}")
    public String listEtudiantsProfesseurexport(@PathVariable Long idElement,Model model, HttpSession session,
                                          @RequestParam(required = false, defaultValue = "") String searchTerm,
                                          @RequestParam(required = false, defaultValue = "") Long filliereId,
                                          @RequestParam(required = false, defaultValue = "") Long semestreId,
                                          @RequestParam(required = false, defaultValue = "") Long codeModule){
        {
            // Récupérer le professeur connecté depuis la session
            Compte Compte = (Compte) session.getAttribute("loggedInUser");
            Professeur professeur = professeurService.getProfesseurById(Compte.getUtilisateur().getCode().toString());
            model.addAttribute("fillieres", filliereService.getAllFillieres());
            model.addAttribute("semestres", semestreService.getAllSemestres());
            model.addAttribute("modules", moduleService.getAllModules());
            model.addAttribute("element", elementService.getElementById(idElement.toString()));
            if (professeur == null) {
                return "redirect:/utilisateur/loginPage";
            }
            // Récupérer uniquement les étudiants associés à ce professeur
            List<Etudiant> etudiantsProfesseur = professeurService.getEtudiantsByProfesseur(professeur.getCode(), searchTerm, filliereId, semestreId, codeModule, idElement);
            model.addAttribute("etudiants", etudiantsProfesseur);
            //model.addAttribute("fillieres", professeur.getFillieres());  // Si le professeur a des filières spécifiques
            return "prof_etudiants-listAexport";
        }
    }















    @GetMapping("/etudiants/notes/{idEtudiant}/{idElement}/modalites")
    @ResponseBody
    public List<Map<String, Object>> getModalites(@PathVariable String idEtudiant,
                                                  @PathVariable String idElement) {
        // Récupérer l'étudiant et l'élément
        Etudiant etudiant = etudiantService.getEtudiantByCode(idEtudiant);
        Element element = elementService.getElementById(idElement);

        // Récupérer toutes les modalités pour cet élément
        List<Modalite_Evaluation> modalites = modalite_evaluationService
                .getAllModalite_Evaluations_byElement(element.getIdElement());

        // Créer la liste de réponse
        List<Map<String, Object>> response = new ArrayList<>();

        for (Modalite_Evaluation modalite : modalites) {
            Map<String, Object> modaliteMap = new HashMap<>();

            // Récupérer la note existante pour cette modalité si elle existe
            NoteModalite noteModalite = noteModaliteService
                    .getNoteModaliteByModaliteAndEtudiant(modalite.getId_Modalite(), etudiant.getCodeEtudiant());

            // Informations de base de la modalité
            modaliteMap.put("id_Modalite", modalite.getId_Modalite());
            modaliteMap.put("type_Modalite", modalite.getType_Modalite());
            modaliteMap.put("coeffecient", modalite.getCoeffecient());

            // Informations de la note si elle existe
            if (noteModalite != null) {
                modaliteMap.put("noteActuelle", noteModalite.getNoteModalite());
                modaliteMap.put("isAbsent", noteModalite.isAbsent());
            } else {
                modaliteMap.put("noteActuelle", null);
                modaliteMap.put("isAbsent", false);
            }

            response.add(modaliteMap);
        }

        return response;
    }

    @GetMapping("/modalites/{elementId}")
    @ResponseBody
    public List<Modalite_Evaluation> getModalites(@PathVariable Long elementId) {
        return modalite_evaluationService.getAllModalite_Evaluations_byElement(elementId);
    }
}


