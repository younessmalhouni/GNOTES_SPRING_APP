package com.example.GNotesAPP12.Repo;
import com.example.GNotesAPP12.Model.Etudiant;
import com.example.GNotesAPP12.Model.Filliere;
import com.example.GNotesAPP12.Model.Module;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
public interface ModuleRepo extends JpaRepository<Module, String> {


    @Query("select sum(el.coefficient) from Element el where el.module.codeModule = :moduleCode")
    Double SommeCoefModule(Long moduleCode);



    @Query("SELECT DISTINCT e FROM Etudiant e " +
            "JOIN e.filliere f " +
            "JOIN f.modules m " +
            "WHERE m.codeModule = :codeModule AND " +
            "(:search IS NULL OR LOWER(e.nomEtudiant) LIKE LOWER(CONCAT('%', :search, '%')) " +
            "OR LOWER(e.prenomEtudiant) LIKE LOWER(CONCAT('%', :search, '%'))) AND " +
            "(:filliereId IS NULL OR e.filliere.idFilliere = :filliereId) AND " +
            "(:semestreId IS NULL OR e.semestre.id_Semestre = :semestreId)")
    List<Etudiant> EtudiantsOfModule(Long codeModule,
                                     @Param("search") String search,
                                     @Param("filliereId") Long filliereId,
                                     @Param("semestreId") Long semestreId);


}
