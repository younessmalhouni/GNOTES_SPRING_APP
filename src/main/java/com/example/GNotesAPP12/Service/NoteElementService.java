package com.example.GNotesAPP12.Service;

import com.example.GNotesAPP12.Model.Element;
import com.example.GNotesAPP12.Model.Modalite_Evaluation;
import com.example.GNotesAPP12.Model.NoteElement;
import com.example.GNotesAPP12.Model.NoteModalite;
import com.example.GNotesAPP12.Repo.NoteElementRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NoteElementService {
    @Autowired
    private NoteElementRepo noteElementRepo;

    @Autowired
    private ElementService ElementService;

    @Autowired
    private NoteModaliteService noteModaliteService;

    public void saveNoteElement(NoteElement noteElement) {
        noteElementRepo.save(noteElement);
    }

    public NoteElement getNoteElementByElementAndEtudiant(Long elementCode, Long etudiantCode) {
        return noteElementRepo.findNoteElementByElementAndEtudiant(elementCode, etudiantCode);
    }

    public double CalculerNoteElement(Long idElement,Long codeEtudiant) {
        Element element = ElementService.getElementById(idElement.toString());
        List<Modalite_Evaluation> modalites = element.getModalites();
        double noteElement = 0;
        for (Modalite_Evaluation modalite : modalites) {
            NoteModalite notemodalite = noteModaliteService.getNoteModaliteByModaliteAndEtudiant(modalite.getId_Modalite(), codeEtudiant);
            if (notemodalite.isAbsent()==true){
                return 0;
            }
            noteElement += notemodalite.getNoteModalite()*modalite.getCoeffecient();
        }

        return noteElement/100;
    }

    public void ValiderNotesSaisies(Long idElement){
        List<NoteElement> notes = noteElementRepo.findNoteElementByElement(idElement);
        for (NoteElement note : notes) {
            note.setValide(true);
            noteElementRepo.save(note);
        }
    }


}
