package com.example.productapp.service;

import com.example.productapp.model.Product;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class InMemoryProductServiceTest {
    private InMemoryProductService service;

    @BeforeEach
    public void setUp() {
        service = InMemoryProductService.getInstance();
    }

    @Test
    public void testCreateAndFind() {
        Product p = new Product();
        p.setName("Test");
        p.setDescription("Desc");
        p.setPrice(new BigDecimal("9.99"));
        Product created = service.create(p);
        assertNotNull(created);
        assertTrue(created.getId() > 0);
        Product found = service.findById(created.getId());
        assertNotNull(found);
        assertEquals("Test", found.getName());
    }

    @Test
    public void testUpdate() {
        Product p = new Product();
        p.setName("Upd");
        p.setDescription("D");
        p.setPrice(new BigDecimal("1.23"));
        Product created = service.create(p);
        created.setName("Updated");
        Product updated = service.update(created);
        assertNotNull(updated);
        assertEquals("Updated", service.findById(created.getId()).getName());
    }

    @Test
    public void testDelete() {
        Product p = new Product();
        p.setName("Del");
        p.setDescription("D");
        p.setPrice(new BigDecimal("2.00"));
        Product created = service.create(p);
        boolean deleted = service.deleteById(created.getId());
        assertTrue(deleted);
        assertNull(service.findById(created.getId()));
    }

    @Test
    public void testSearch() {
        service.create(new Product(0, "SearchMe", "x", new BigDecimal("1"), null));
        List<Product> results = service.searchByName("search");
        assertTrue(results.stream().anyMatch(r -> r.getName().toLowerCase().contains("search")));
    }
}
