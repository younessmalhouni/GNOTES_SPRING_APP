package com.example.GNotesAPP12.Repo;

import com.example.GNotesAPP12.Model.NoteElement;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NoteElementRepo extends JpaRepository<NoteElement, Long> {

    @Query("select n from NoteElement n where n.element.idElement = :elementCode and n.etudiant.codeEtudiant = :etudiantCode")
    NoteElement findNoteElementByElementAndEtudiant(Long elementCode, Long etudiantCode);

    @Query("select n from NoteElement n where n.element.idElement = :elementCode ")
    List<NoteElement> findNoteElementByElement(Long elementCode);

}
