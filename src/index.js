import './main.css';
import { Elm } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';
import {Howl, Howler} from 'howler';


const kick = new Howl({src:["assets/kick.wav"]});
const snare = new Howl({src: ['static/assets/snare.wav']});
const hat = new Howl({src: ['static/assets/hat.wav']});
const perc = new Howl({src: ['static/assets/perc.wav']});
const perc1 = new Howl({src: ['static/assets/perc1.wav']});
const perc2 = new Howl({src: ['static/assets/perc2.wav']});
const perc3 = new Howl({src: ['static/assets/perc3.wav']});
const perc4 = new Howl({src: ['static/assets/perc4.wav']});
const fx1 = new Howl({src: ['static/assets/fx1.wav']});
const lowWomp = new Howl({src: ['static/assets/low-womp.wav']});
const highWomp = new Howl({src: ['static/assets/high-womp.wav']});
const tick = new Howl({src: ['static/assets/tick.wav']});
 


window.addEventListener("load", (e) => {
  console.log(e)
})

const switchSample = (str) => {
  switch (str) {
    case "kick":
      kick.play()
      break
    case "snare":
      snare.play()
      break
    case "perc":
      perc.play()
      break
    case "hat":
      hat.play()
      break
    case "perc1":
      perc1.play()
      break
    case "perc2":
      perc2.play()
      break
    case "perc3":
      perc3.play()
      break
    case "perc4":
      perc4.play()
      break
    case "fx1":
      fx1.play()
      break
    case "tick":
      tick.play()
      break
    case "lowWomp":
      lowWomp.play()
      break
    case "highWomp":
      highWomp.play()
      break
  }
}

const isPlaying = (audelem) => { return !audelem.paused; }


const app = Elm.Main.init({
  node: document.getElementById('root')
});

app.ports.playSound.subscribe(function(data) {
  localStorage.setItem('cache', JSON.stringify(data));
  const packet = JSON.parse(data)
  packet.map((ele) => {
    switchSample(ele)
  })
});

registerServiceWorker();

