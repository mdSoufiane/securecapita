package io.getarrays.securecapita.repository;

import io.getarrays.securecapita.domain.Role;
import io.getarrays.securecapita.domain.User;
import org.springframework.stereotype.Repository;

import java.util.Collection;

@Repository
public interface RoleRepository<T extends Role> {
    /*Basic CRUD Operations */
    T create(T data);
    Collection<T> list(int page, int pageSize);
    T get(Long id);
    T update(T data);
    Boolean delete(Long id);

    /*More Complex Operations */
    void addRoleToUser(Long userId,String roleName);
    Role getRoleByUserId(Long userId);
    Role getRoleByUserEmail(String email);
    void updateUserRole(Long userId, String roleName);
}
