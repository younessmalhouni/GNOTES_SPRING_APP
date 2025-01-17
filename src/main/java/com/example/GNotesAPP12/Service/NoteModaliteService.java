package com.example.GNotesAPP12.Service;


import com.example.GNotesAPP12.Model.NoteModalite;
import com.example.GNotesAPP12.Repo.NoteModaliteRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NoteModaliteService {
    @Autowired
    private NoteModaliteRepo noteModaliteRepository;

    public List<NoteModalite> getAllNoteModalites() {
        return noteModaliteRepository.findAll();
    }

    public void saveNoteModalite(NoteModalite noteModalite) {
        noteModaliteRepository.save(noteModalite);
    }

    public NoteModalite getNoteModaliteByModaliteAndEtudiant(Long modaliteCode, Long etudiantCode) {
        return noteModaliteRepository.findNoteModaliteByModaliteEvaluation_IdAndEtudiant_Id(modaliteCode, etudiantCode);
    }


}
