import { PromptManager } from '../ai-tools/prompt-manager.js';

describe('AI Tools', () => {
  let promptManager;

  beforeEach(() => {
    promptManager = new PromptManager();
  });

  test('should create prompt', () => {
    const prompt = promptManager.createPrompt('Test', 'Test content');
    expect(prompt.name).toBe('Test');
    expect(prompt.content).toBe('Test content');
  });

  test('should list prompts by category', () => {
    promptManager.createPrompt('P1', 'Content', 'code');
    promptManager.createPrompt('P2', 'Content', 'writing');
    const codePrompts = promptManager.listPrompts('code');
    expect(codePrompts.length).toBe(1);
  });

  test('should track usage', () => {
    const prompt = promptManager.createPrompt('Test', 'Content');
    promptManager.recordUsage(prompt.id);
    expect(promptManager.getPrompt(prompt.id).usage).toBe(1);
  });
});
