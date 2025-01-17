package com.example.GNotesAPP12.Service;

import com.example.GNotesAPP12.Model.Etudiant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.GNotesAPP12.Repo.EtudiantRepo;

import java.util.List;

@Service
public class EtudiantService {

    @Autowired
    private EtudiantRepo etudiantRepo;

    public List<Etudiant> getAllEtudiants() {
        return etudiantRepo.findAll();
    }

    public Etudiant getEtudiantByCode(String id) {
        return etudiantRepo.findById(id).orElse(null);
    }

    public void saveEtudiant(Etudiant etudiant) {
        etudiantRepo.save(etudiant);
    }

    public void deleteEtudiant(String id) {
        etudiantRepo.deleteById(id);
    }

    public List<Etudiant> searchEtudiants(String searchTerm,Long filliereId, Long semestreId) {

        if (searchTerm == null || searchTerm.trim().isEmpty() && filliereId == null && semestreId == null) {
            return etudiantRepo.findAll();
        } else {
            return etudiantRepo.searchEtudiants(searchTerm.trim(), filliereId, semestreId);
        }
    }



}
