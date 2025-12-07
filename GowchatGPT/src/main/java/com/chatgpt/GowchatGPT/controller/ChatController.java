package com.chatgpt.GowchatGPT.controller;

import com.chatgpt.GowchatGPT.service.GroqService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/chat")
@CrossOrigin("*")
public class ChatController {

    private final GroqService groqService;

    public ChatController(GroqService groqService) {
        this.groqService = groqService;
    }

    @PostMapping
    public String chat(@RequestBody String message) {
        return groqService.getChatResponse(message);
    }
}
