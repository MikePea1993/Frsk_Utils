document.addEventListener("DOMContentLoaded", function () {
  // DOM Elements
  const promptContainer = document.getElementById("prompt-container");
  const keyElement = document.getElementById("key");
  const keyTextElement = document.querySelector(".key-text");
  const actionText = document.querySelector(".action-text");

  // State
  let currentKey = null;

  // Show prompt with animation
  function showPrompt(location, key, buttonText) {
    if (!promptContainer || !keyElement || !keyTextElement || !actionText)
      return;

    currentKey = key;
    keyElement.textContent = key;
    keyTextElement.textContent = buttonText || "USE";
    actionText.textContent = location;

    promptContainer.classList.remove("fade-out");
    promptContainer.style.display = "block";
    promptContainer.classList.add("fade-in");
  }

  // Hide prompt with animation
  function hidePrompt() {
    if (!promptContainer) return;

    promptContainer.classList.remove("fade-in");
    promptContainer.classList.add("fade-out");

    setTimeout(() => {
      promptContainer.style.display = "none";
      currentKey = null;
    }, 300);
  }

  // Message handler
  window.addEventListener("message", function (event) {
    const data = event.data;

    switch (data.type) {
      case "showPrompt":
        showPrompt(data.location, data.key, data.buttonText);
        break;

      case "hidePrompt":
        hidePrompt();
        break;
    }
  });

  // Key press animation
  document.addEventListener("keydown", function (event) {
    if (currentKey && event.key.toUpperCase() === currentKey) {
      keyElement.classList.add("pressed");
    }
  });

  document.addEventListener("keyup", function (event) {
    if (currentKey && event.key.toUpperCase() === currentKey) {
      keyElement.classList.remove("pressed");
    }
  });

  // Prevent context menu
  document.addEventListener("contextmenu", function (event) {
    event.preventDefault();
    return false;
  });

  // Prevent text selection
  document.addEventListener("selectstart", function (event) {
    event.preventDefault();
    return false;
  });
});
