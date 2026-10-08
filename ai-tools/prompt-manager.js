/**
 * WISE² AI Prompt Management System
 * Store, organize, and version control prompts
 */

class PromptManager {
  constructor(storageKey = 'wise2_prompts') {
    this.storageKey = storageKey;
    this.prompts = this.loadPrompts();
  }

  createPrompt(name, content, category = 'general', tags = []) {
    const id = Date.now().toString();
    const prompt = {
      id,
      name,
      content,
      category,
      tags,
      created: new Date().toISOString(),
      updated: new Date().toISOString(),
      version: 1,
      usage: 0
    };
    this.prompts[id] = prompt;
    this.save();
    return prompt;
  }

  getPrompt(id) {
    return this.prompts[id] || null;
  }

  updatePrompt(id, updates) {
    if (this.prompts[id]) {
      this.prompts[id] = {
        ...this.prompts[id],
        ...updates,
        updated: new Date().toISOString(),
        version: this.prompts[id].version + 1
      };
      this.save();
      return this.prompts[id];
    }
    return null;
  }

  deletePrompt(id) {
    delete this.prompts[id];
    this.save();
  }

  listPrompts(category = null, tags = []) {
    return Object.values(this.prompts).filter(p => {
      if (category && p.category !== category) return false;
      if (tags.length && !tags.some(t => p.tags.includes(t))) return false;
      return true;
    });
  }

  recordUsage(id) {
    if (this.prompts[id]) {
      this.prompts[id].usage++;
      this.save();
    }
  }

  exportPrompt(id) {
    const prompt = this.prompts[id];
    return JSON.stringify(prompt, null, 2);
  }

  importPrompt(jsonData) {
    try {
      const prompt = JSON.parse(jsonData);
      const newId = Date.now().toString();
      this.prompts[newId] = { ...prompt, id: newId };
      this.save();
      return this.prompts[newId];
    } catch (e) {
      console.error('Import failed:', e);
      return null;
    }
  }

  save() {
    try {
      localStorage.setItem(this.storageKey, JSON.stringify(this.prompts));
      return true;
    } catch (e) {
      console.error('Save failed:', e);
      return false;
    }
  }

  loadPrompts() {
    try {
      const data = localStorage.getItem(this.storageKey);
      return data ? JSON.parse(data) : {};
    } catch (e) {
      return {};
    }
  }

  clear() {
    this.prompts = {};
    localStorage.removeItem(this.storageKey);
  }
}

// Built-in prompt templates
const PromptTemplates = {
  'code-review': {
    name: 'Code Review Assistant',
    category: 'development',
    content: `You are an expert code reviewer. Analyze the provided code and give:
1. Code quality assessment
2. Security vulnerabilities
3. Performance suggestions
4. Readability improvements
5. Specific recommendations with code examples`
  },

  'data-analysis': {
    name: 'Data Analysis Expert',
    category: 'analysis',
    content: `You are a data analysis specialist. For the provided data:
1. Identify key trends and patterns
2. Statistical summary
3. Anomalies and outliers
4. Recommendations for action
5. Visualization suggestions`
  },

  'content-writer': {
    name: 'Content Writer',
    category: 'writing',
    content: `You are a professional content writer. Create engaging, clear content:
1. Match the specified tone and audience
2. Include compelling headlines
3. Use structured sections with clear hierarchy
4. Add relevant examples
5. Call-to-action where appropriate`
  },

  'api-design': {
    name: 'API Design Consultant',
    category: 'development',
    content: `You are an API design expert. Review or design REST APIs with:
1. Consistent naming conventions
2. Proper HTTP method usage
3. Meaningful status codes
4. Clear error handling
5. Security best practices`
  }
};

if (typeof module !== 'undefined' && module.exports) {
  module.exports = { PromptManager, PromptTemplates };
}
