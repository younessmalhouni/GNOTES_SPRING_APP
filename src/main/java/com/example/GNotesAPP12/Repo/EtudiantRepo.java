package com.example.GNotesAPP12.Repo;

import com.example.GNotesAPP12.Model.Etudiant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EtudiantRepo extends JpaRepository<Etudiant, String> {
    @Query("SELECT e FROM Etudiant e WHERE " +
            "(:search IS NULL OR LOWER(e.nomEtudiant) LIKE LOWER(CONCAT('%', :search, '%')) OR LOWER(e.prenomEtudiant) LIKE LOWER(CONCAT('%', :search, '%'))) AND " +
            "(:filliereId IS NULL OR e.filliere.idFilliere = :filliereId) AND " +
            "(:semestreId IS NULL OR e.semestre.id_Semestre = :semestreId)")
    List<Etudiant> searchEtudiants(
            @Param("search") String search,
            @Param("filliereId") Long filliereId,
            @Param("semestreId") Long semestreId
    );
}
