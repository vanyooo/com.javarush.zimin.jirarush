package com.javarush.jira.profile.internal.web;

import com.javarush.jira.AbstractControllerTest;
import com.javarush.jira.common.BaseHandler;
import com.javarush.jira.common.util.JsonUtil;
import com.javarush.jira.login.internal.web.UserTestData;
import com.javarush.jira.profile.ProfileTo;
import com.javarush.jira.profile.internal.ProfileRepository;
import com.javarush.jira.profile.internal.model.Profile;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithUserDetails;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import java.util.stream.Stream;

import static com.javarush.jira.profile.internal.web.ProfileTestData.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

class ProfileRestControllerTest extends AbstractControllerTest {

    private static final String REST_URL_PROFILE = BaseHandler.REST_URL + "/profile";

    @Autowired
    private ProfileRepository profileRepository;

    // Тест получения профиля авторизованного пользователя USER
    @Test
    @WithUserDetails(UserTestData.USER_MAIL)
    void getProfileAsUser() throws Exception {
        perform(MockMvcRequestBuilders.get(REST_URL_PROFILE))
                .andExpect(status().isOk())
                .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON))
                .andExpect(PROFILE_TO_MATCHER.contentJson(USER_PROFILE_TO));
    }

    // Тест получения профиля пользователем GUEST
    @Test
    @WithUserDetails(UserTestData.GUEST_MAIL)
    void getProfileAsGuest() throws Exception {
        perform(MockMvcRequestBuilders.get(REST_URL_PROFILE))
                .andExpect(status().isOk())
                .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON))
                .andExpect(PROFILE_TO_MATCHER.contentJson(GUEST_PROFILE_EMPTY_TO));
    }

    // Тест получения профиля без авторизации (ожидаем 401 Unauthorized)
    @Test
    void getProfileUnauthorized() throws Exception {
        perform(MockMvcRequestBuilders.get(REST_URL_PROFILE))
                .andExpect(status().isUnauthorized())
                .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON));
    }

    // Тест обновления профиля авторизованного пользователя USER
    @Test
    @WithUserDetails(UserTestData.USER_MAIL)
    void updateProfileAsUser() throws Exception {
        long userId = 1L;
        ProfileTo updatedTo = getUpdatedTo(userId);

        perform(MockMvcRequestBuilders.put(REST_URL_PROFILE)
                .contentType(MediaType.APPLICATION_JSON)
                .content(JsonUtil.writeValue(updatedTo)))
                .andExpect(status().isNoContent());

        Profile expected = getUpdated(userId);
        Profile actual = profileRepository.findById(userId).orElseThrow();
        PROFILE_MATCHER.assertMatch(actual, expected);
    }

    // Тест обновления профиля новым пользователем MANAGER
    @Test
    @WithUserDetails(UserTestData.MANAGER_MAIL)
    void updateProfileAsNewManager() throws Exception {
        ProfileTo newTo = getNewTo();

        perform(MockMvcRequestBuilders.put(REST_URL_PROFILE)
                .contentType(MediaType.APPLICATION_JSON)
                .content(JsonUtil.writeValue(newTo)))
                .andExpect(status().isNoContent());

        long newUserId = 4L;
        Profile expected = getNew(newUserId);
        Profile actual = profileRepository.getExisted(newUserId);
        PROFILE_MATCHER.assertMatch(actual, expected);
    }

    // Параметризованный тест обновления профиля с некорректными данными
    @ParameterizedTest
    @MethodSource("invalidProfileTos")
    @WithUserDetails(UserTestData.MANAGER_MAIL)
    void updateProfileWithInvalidData(ProfileTo invalidTo) throws Exception {
        perform(MockMvcRequestBuilders.put(REST_URL_PROFILE)
                .contentType(MediaType.APPLICATION_JSON)
                .content(JsonUtil.writeValue(invalidTo)))
                .andExpect(status().is4xxClientError());
    }

    // Источник данных для параметризованного теста - различные некорректные объекты ProfileTo
    private static Stream<Arguments> invalidProfileTos() {
        return Stream.of(
                Arguments.of(getInvalidTo()),
                Arguments.of(getWithUnknownNotificationTo()),
                Arguments.of(getWithUnknownContactTo()),
                Arguments.of(getWithContactHtmlUnsafeTo())
        );
    }
}
