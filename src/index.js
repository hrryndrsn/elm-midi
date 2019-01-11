import './main.css';
import { Elm } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

const audio = new Audio("./assets/snare.wav")

window.addEventListener("load", (e) => {
  console.log(e)
})


const app = Elm.Main.init({
  node: document.getElementById('root')
});

app.ports.playSound.subscribe(function(data) {
  localStorage.setItem('cache', JSON.stringify(data));
  audio.play();
  console.log(JSON.parse(data))
});

registerServiceWorker();

