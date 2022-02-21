function animateAsync(element, keyframes, options) {
  return new Promise(res => {
    const anim = element.animate(keyframes, options);

    // anim.onfinish = res; <- not supported on Safari
    setTimeout(res, options.duration || 0);
  })
}


function createImageSlider(
  images,
  {
    currentSlideIndex = 0,
    duration = 750,
    easing = 'cubic-bezier(0.250, 0.460, 0.450, 0.940)',
    slideShowInterval = 4000
  } = {}
) {
  const slider = document.createElement('div');
  slider.className = 'slider';
  slider.innerHTML =
    '<div class="slides-wrapper"></div>' +
    '<div class="slide-indicators"></div>' +
    '<button type="button" class="prev-button"></button>' +
    '<button type="button" class="next-button"></button>';
  const [wrapper, indicators, prevBtn, nextBtn] = slider.children;
  const fill = 'forwards';
  let animating = false;
  let timer = null;

  images.forEach((img, idx) => {
    const slide = document.createElement('div');
    const btn = document.createElement('button');
    const image = document.createElement('img');
    const activeCls = idx === currentSlideIndex ? 'active' : '';
    slide.className = `slide ${activeCls}`;
    btn.className = activeCls;
    image.src = img;

    btn.style.transitionDuration = `${duration}ms`;
    btn.addEventListener('click', () => slideTo(idx));

    slide.appendChild(image);
    wrapper.appendChild(slide);
    indicators.appendChild(btn);
  });

  function autoSlide() {
    timer = setTimeout(
      () => slideTo(currentSlideIndex === images.length - 1 ? 0 : currentSlideIndex + 1),
      slideShowInterval
    );
  }

  function slideTo(index) {
    if (index === currentSlideIndex || animating) {
      return;
    }

    animating = true;

    clearTimeout(timer);
    const currentSlide = wrapper.children[currentSlideIndex];
    const nextSlide = wrapper.children[index];

    indicators.children[currentSlideIndex].classList.remove('active');
    indicators.children[index].classList.add('active');
    const pos = index > currentSlideIndex ? '-100%' : '100%';

    Promise.all([
      animateAsync(nextSlide, [
        { transform: `translate(${parseInt(pos, 10) * -1}%, 0)` },
        { transform: 'translate(0, 0)' }
      ], { duration, fill, easing }),
      animateAsync(currentSlide, [
        { transform: 'translate(0, 0)' },
        { transform: `translate(${pos}, 0)` }
      ], { duration, fill, easing })
    ]).then(() => {
      currentSlideIndex = index;
      currentSlide.classList.remove('active');
      nextSlide.classList.add('active');
      animating = false;

      autoSlide();
    });
  };

  nextBtn.addEventListener('click', () =>
    slideTo(Math.min(currentSlideIndex + 1, images.length - 1)));
  prevBtn.addEventListener('click', () =>
    slideTo(Math.max(0, currentSlideIndex - 1)));

  autoSlide();

  return slider;
}

document.querySelector(".homepage-caroussel").appendChild(createImageSlider([
  'https://res.cloudinary.com/dajifvnn5/image/upload/v1645110270/Christmas_Cart_jimfgj.jpg',
  'https://res.cloudinary.com/dajifvnn5/image/upload/v1645110270/Shopping_screen_mxaypo.jpg',
  'https://res.cloudinary.com/dajifvnn5/image/upload/v1645110270/Shopping_paper_list_iazl1e.jpg',
  'https://res.cloudinary.com/dajifvnn5/image/upload/v1645110268/Chanel_lx8idp.jpg',
  'https://res.cloudinary.com/dajifvnn5/image/upload/v1645311872/tamanna-rumee-eD1RNYzzUxc-unsplash_c5ovzh.jpg'
]))
