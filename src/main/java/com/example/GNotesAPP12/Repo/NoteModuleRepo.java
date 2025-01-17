package com.example.GNotesAPP12.Repo;

import com.example.GNotesAPP12.Model.NoteModule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface NoteModuleRepo extends JpaRepository<NoteModule, Long> {

    @Query("select n from NoteModule n where n.module.codeModule = :moduleId and n.etudiant.codeEtudiant = :etudiantId")
    NoteModule findNoteModuleByModule_IdAndEtudiant_Id(Long moduleId, Long etudiantId);
}
