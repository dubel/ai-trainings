(() => {
  const slides = [...document.querySelectorAll(".slide")];
  const stage = document.getElementById("stage");
  const progress = document.getElementById("progress");
  const counter = document.getElementById("counter");
  const controls = document.getElementById("controls");
  const themes = ["paloalto", "ocean", "forest"];
  let index = Math.max(0, Math.min(slides.length - 1, Number(location.hash.slice(1) || 1) - 1));

  slides.forEach((slide, slideIndex) => slide.dataset.index = String(slideIndex + 1).padStart(2, "0"));

  function fit() {
    if (document.body.classList.contains("grid-mode")) return;
    const scale = Math.min(innerWidth / 1280, innerHeight / 720);
    stage.style.transform = `scale(${scale})`;
  }

  function show(next) {
    index = Math.max(0, Math.min(slides.length - 1, next));
    slides.forEach((slide, slideIndex) => slide.classList.toggle("active", slideIndex === index));
    counter.textContent = `${String(index + 1).padStart(2, "0")} / ${String(slides.length).padStart(2, "0")}`;
    progress.style.width = `${((index + 1) / slides.length) * 100}%`;
    document.title = `${slides[index].dataset.title} · Claude Code workshop`;
    history.replaceState(null, "", `#${index + 1}`);
  }

  function toggleGrid(force) {
    const on = typeof force === "boolean" ? force : !document.body.classList.contains("grid-mode");
    document.body.classList.toggle("grid-mode", on);
    stage.style.transform = "";
    if (!on) fit();
  }

  function cycleTheme() {
    const current = document.documentElement.dataset.theme;
    document.documentElement.dataset.theme = themes[(themes.indexOf(current) + 1) % themes.length];
  }

  document.getElementById("prev").addEventListener("click", () => show(index - 1));
  document.getElementById("next").addEventListener("click", () => show(index + 1));
  slides.forEach((slide, slideIndex) => slide.addEventListener("click", () => {
    if (document.body.classList.contains("grid-mode")) {
      toggleGrid(false);
      show(slideIndex);
    }
  }));
  addEventListener("resize", fit);
  addEventListener("keydown", (event) => {
    if (["ArrowRight", "PageDown", " "].includes(event.key)) { event.preventDefault(); show(index + 1); }
    if (["ArrowLeft", "PageUp"].includes(event.key)) { event.preventDefault(); show(index - 1); }
    if (event.key === "Home") show(0);
    if (event.key === "End") show(slides.length - 1);
    if (event.key.toLowerCase() === "g") toggleGrid();
    if (event.key === "Escape" && document.body.classList.contains("grid-mode")) toggleGrid(false);
    if (event.key.toLowerCase() === "h") controls.classList.toggle("hidden");
    if (event.key.toLowerCase() === "t") cycleTheme();
    if (event.key.toLowerCase() === "f") document.fullscreenElement ? document.exitFullscreen() : document.documentElement.requestFullscreen();
  });

  fit();
  show(index);
})();

