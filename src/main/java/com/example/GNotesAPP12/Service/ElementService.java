package com.example.GNotesAPP12.Service;

import com.example.GNotesAPP12.Model.Element;
import com.example.GNotesAPP12.Model.Module;
import com.example.GNotesAPP12.Repo.ElementRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ElementService {

    private final ElementRepo elementRepository;

    public ElementService(ElementRepo elementRepository) {
        this.elementRepository = elementRepository;
    }

    public List<Element> getElementsByIds(List<String> ids) {
        return elementRepository.findAllById(ids);
    }

    public List<Element> getAllElements() {
        return elementRepository.findAll();
    }

    public Element getElementById(String id) {
        return elementRepository.findById(id).orElse(null);
    }

    public void deleteElement(String id) {
        elementRepository.deleteById(id);
    }

    public void saveElement(Element element) {
        elementRepository.save(element);
    }

    public List<Element> SearchElements(String moduleId, String profId, String searchTerm) {
        return elementRepository.findElementsWithFilters(
                moduleId.isEmpty() ? null : moduleId,
                profId.isEmpty() ? null : profId,
                searchTerm.isEmpty() ? null : searchTerm
        );
    }

    public Double SommeCoefElement(Long elementCode) {
        return elementRepository.SommeCoefElement(elementCode);
    }

    public Element ElementExistant(Long id) {
        return elementRepository.ElementExistant(id);
    }


}

