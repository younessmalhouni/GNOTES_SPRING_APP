package com.example.GNotesAPP12.Service;


import com.example.GNotesAPP12.Model.*;
import com.example.GNotesAPP12.Model.Module;
import com.example.GNotesAPP12.Repo.NoteModuleRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class NoteModuleService {


    @Autowired
    private NoteModuleRepo noteModuleRepo;

    @Autowired
    NoteElementService NoteElementService;

    public boolean isElementsOfModuleValid(Module module, Etudiant etudiant) {
        List<Element> elementsofModule = module.getElements();
        List<NoteElement> noteElements = new ArrayList<>();
        for (Element element : elementsofModule) {
            NoteElement noteElement = NoteElementService.getNoteElementByElementAndEtudiant(element.getIdElement(), etudiant.getCodeEtudiant());
            if (noteElement.getIsValide() == false) {
                return false;
            } else {
                noteElements.add(noteElement);
            }
        }

        if (noteElements.size() == elementsofModule.size()) {
            return true;
        }
        return false;

    }

    public NoteModule getNoteModuleByModule_IdAndEtudiant_Id    (Long moduleId, Long etudiantId) {
        return noteModuleRepo.findNoteModuleByModule_IdAndEtudiant_Id(moduleId, etudiantId);
    }

    public double calculateModuleNoteForEtudiant(Module module, Etudiant etudiant) {
        double noteModule = 0;
        List<Element> elementsofModule = module.getElements();
        for (Element element : elementsofModule) {
            NoteElement noteElement = NoteElementService.getNoteElementByElementAndEtudiant(element.getIdElement(), etudiant.getCodeEtudiant());
            noteModule += noteElement.getNoteElement() * (element.getCoefficient()/100);
        }
        return noteModule;
    }

    public void saveNoteModule(NoteModule noteModule) {
        noteModuleRepo.save(noteModule);
    }
}

