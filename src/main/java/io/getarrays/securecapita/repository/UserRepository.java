package io.getarrays.securecapita.repository;

import io.getarrays.securecapita.domain.User;
import org.springframework.stereotype.Repository;

import java.util.Collection;

/**
 * @author Soufiane D
 * @version 1.0
 * @since 05/07/2023
 * @param <T>
 */
public interface UserRepository<T extends User> {
    /*Basic CRUD Operations */
    T create(T data);
    Collection<T> list(int page, int pageSize);
    T get(Long id);
    T update(T data);
    Boolean delete(Long id);

    /*More Complex Operations */
}
