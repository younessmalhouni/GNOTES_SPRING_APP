package com.example.GNotesAPP12.Service;

import com.example.GNotesAPP12.Model.Element;
import com.example.GNotesAPP12.Model.Etudiant;
import com.example.GNotesAPP12.Model.Module;
import com.example.GNotesAPP12.Model.NoteElement;
import com.example.GNotesAPP12.Repo.ModuleRepo;
import com.example.GNotesAPP12.Repo.NoteElementRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ModuleService {
    @Autowired
    private ModuleRepo moduleRepo;
    @Autowired
    private NoteElementRepo noteElementRepo;

    public List<Module> getAllModules() {
        return moduleRepo.findAll();
    }

    public Module getModuleById(String id) {
        return moduleRepo.findById(id).orElse(null);
    }

    public void saveModule(Module module) {
        moduleRepo.save(module);
    }

    public void deleteModule(String id) {
        moduleRepo.deleteById(id);
    }
    public Double SommeCoefModule(Long CodeModule) {
        return moduleRepo.SommeCoefModule(CodeModule);
    }

    public Double SommeCoefModuleexceptElement(Long CodeModule, Element element) {
        return moduleRepo.SommeCoefModule(CodeModule) - element.getCoefficient();
    }
    public Double CalculerNoteModule(Long CodeModule, Long CodeEtudiant) {
        Module module = getModuleById(CodeModule.toString());
        List<Element> elements = module.getElements();
        Double somme = 0.0;
        Double coef = 0.0;
        for (Element element : elements) {
            NoteElement noteElement = noteElementRepo.findNoteElementByElementAndEtudiant(element.getIdElement(), CodeEtudiant);
            if (noteElement == null) {
                return null;
            }
            somme += noteElement.getNoteElement() * element.getCoefficient();

        }
        Double noteModule = somme / 100;
        return noteModule;
    }

    public List<Etudiant> EtudiantsOfModule(Long moduleId, Long semestreId, Long filliereId, String searchTerm) {
        return moduleRepo.EtudiantsOfModule(moduleId, searchTerm,semestreId, filliereId);
    }


}
