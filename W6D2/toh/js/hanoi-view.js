class View {
  constructor(game, $rootEl) {
    this.game = game;
    this.$towers = $rootEl;
    this.setupTowers();
    this.bindEvents();
  }

  setupTowers() {
    for (let i = 0; i < 3; i++) {
      const $tower = $('<ul></ul>');
      $tower.data('id', i);

      // add three lis to each tower
      for (let j = 0; j < 3; j++) {
        const $li = $('<li></li>');
        if (i === 0){
          $li.addClass(`disc-${j}`);
        } else {
          $li.attr('class',"");
        }
        $tower.append($li);
      }

      this.$towers.append($tower);
    }
  }

  bindEvents(){
    let startTowerIdx, endTowerIdx;

    // add click handler for start tower
    this.$towers.on('click', 'ul', (event) => {
      const $tower = $(event.currentTarget);
      if (!(typeof startTowerIdx === 'number')) {
        startTowerIdx = $tower.data('id');
      } else {
        endTowerIdx = $tower.data('id');
      }

      if ((typeof startTowerIdx === 'number') && (typeof endTowerIdx === 'number')) {
        const result = this.game.move(startTowerIdx, endTowerIdx);
        if (!result) {
          alert('Invalid move.');
        } else {

          this.render(startTowerIdx, endTowerIdx);
        }
        [startTowerIdx, endTowerIdx] = [false, false];
      }
    });
  }

  render(startTowerIdx, endTowerIdx){
    // get class of top disc in start tower
    const startTower = this.$towers.children()[startTowerIdx];
    const disc = $(startTower).find("[class^='disc-']").first();

    // find first "blank" disc in end tower
    const endTower = this.$towers.children()[endTowerIdx];
    const endDisc = $(endTower).find('[class=""]').last();
    console.log(endDisc);
    endDisc.css('background-color', 'red');

    // addClass to end tower's disc

    // removeClass from first tower's top disc
  }
}

module.exports = View;
