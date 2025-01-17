package com.example.GNotesAPP12.Service;

import com.example.GNotesAPP12.Model.Element;
import com.example.GNotesAPP12.Model.Etudiant;
import com.example.GNotesAPP12.Model.Professeur;
import com.example.GNotesAPP12.Repo.ProfesseurRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProfesseurService {

    @Autowired
    private ProfesseurRepo professeurRepo;

    public List<Professeur> getAllProfesseurs() {
        return professeurRepo.findAll();
    }

    public Professeur getProfesseurById(String id) {
        return professeurRepo.findById(id).orElse(null);
    }

    public void saveProfesseur(Professeur professeur) {
        professeurRepo.save(professeur);
    }

    public void deleteProfesseur(String id) {
        professeurRepo.deleteById(id);
    }

    public List<String> getAllSpecialities() {
        return professeurRepo.findAllSpecialities();
    }


    public List<Professeur> searchProfesseurs(String searchTerm, String specialite) {
        // If both parameters are empty or null, return all professors
        if ((searchTerm == null || searchTerm.trim().isEmpty()) &&
                (specialite == null || specialite.trim().isEmpty())) {
            return professeurRepo.findAll();
        }

        // Trim the search term if it exists
        String trimmedSearchTerm = searchTerm == null ? "" : searchTerm.trim();
        String trimmedSpecialite = specialite == null ? "" : specialite.trim();

        return professeurRepo.searchProfesseurs(trimmedSearchTerm, trimmedSpecialite);
    }


    //Traitements Des profs



    public List<Etudiant> getEtudiantsByProfesseur(Long professeurId, String searchTerm, Long filliereId, Long semestreId, Long codeModule,Long idElement) {
        return professeurRepo.findByFilters(professeurId, searchTerm, filliereId, semestreId, codeModule, idElement);
    }

    public List<Element> getElementsByProfesseur(Long professeurId, String searchTerm, Long filliereId, Long semestreId, Long codeModule) {
        return professeurRepo.ElementsByProfesseur(professeurId, searchTerm, filliereId, semestreId, codeModule);
    }


    public List<Element> ElementsByEtudiantandProfesseur(Long professeurId, Long etudiantId) {
        return professeurRepo.getElementsByEtudiantandProf(professeurId, etudiantId);
    }

}
