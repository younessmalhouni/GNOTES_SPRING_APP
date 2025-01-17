package com.example.GNotesAPP12.Repo;

import com.example.GNotesAPP12.Model.NoteModalite;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface NoteModaliteRepo extends JpaRepository<NoteModalite, Long> {
    @Query("select n from NoteModalite n where n.modaliteEvaluation.id_Modalite = :modaliteId and n.etudiant.codeEtudiant = :etudiantId")
    NoteModalite findNoteModaliteByModaliteEvaluation_IdAndEtudiant_Id(Long modaliteId, Long etudiantId);
}