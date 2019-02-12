import Vue from 'vue';
import { createStore } from '~/mr_notes/stores';
import ParallelDiffTableRow from '~/diffs/components/parallel_diff_table_row.vue';
import { parallelizeDiffLines } from '~/diffs/store/utils';
import { createComponentWithStore } from 'spec/helpers/vue_mount_component_helper';
import diffFileMockData from '../mock_data/diff_file';

describe('ParallelDiffTableRow', () => {
  describe('when one side is empty', () => {
    let vm;
    let diffFileMock;
    let thisLine;
    let rightLine;

    beforeEach(() => {
      diffFileMock = {
        ...diffFileMockData,
        parallel_diff_lines: parallelizeDiffLines(diffFileMockData.highlighted_diff_lines),
      };

      // eslint-disable-next-line prefer-destructuring
      thisLine = diffFileMock.parallel_diff_lines[0];
      rightLine = diffFileMock.parallel_diff_lines[0].right;

      vm = createComponentWithStore(Vue.extend(ParallelDiffTableRow), createStore(), {
        line: thisLine,
        fileHash: diffFileMock.file_hash,
        contextLinesPath: 'contextLinesPath',
        isHighlighted: false,
      }).$mount();
    });

    it('does not highlight non empty line content when line does not match highlighted row', done => {
      vm.$nextTick()
        .then(() => {
          expect(vm.$el.querySelector('.line_content.right-side').classList).not.toContain('hll');
        })
        .then(done)
        .catch(done.fail);
    });

    it('highlights nonempty line content when line is the highlighted row', done => {
      vm.$nextTick()
        .then(() => {
          vm.$store.state.diffs.highlightedRow = rightLine.line_code;

          return vm.$nextTick();
        })
        .then(() => {
          expect(vm.$el.querySelector('.line_content.right-side').classList).toContain('hll');
        })
        .then(done)
        .catch(done.fail);
    });
  });

  describe('when both sides have content', () => {
    let vm;
    let diffFileMock;
    let thisLine;
    let rightLine;

    beforeEach(() => {
      diffFileMock = {
        ...diffFileMockData,
        parallel_diff_lines: parallelizeDiffLines(diffFileMockData.highlighted_diff_lines),
      };

      // eslint-disable-next-line prefer-destructuring
      thisLine = diffFileMock.parallel_diff_lines[2];
      rightLine = diffFileMock.parallel_diff_lines[2].right;

      vm = createComponentWithStore(Vue.extend(ParallelDiffTableRow), createStore(), {
        line: thisLine,
        fileHash: diffFileMock.file_hash,
        contextLinesPath: 'contextLinesPath',
        isHighlighted: false,
      }).$mount();
    });

    it('does not highlight  either line when line does not match highlighted row', done => {
      vm.$nextTick()
        .then(() => {
          expect(vm.$el.querySelector('.line_content.right-side').classList).not.toContain('hll');
          expect(vm.$el.querySelector('.line_content.left-side').classList).not.toContain('hll');
        })
        .then(done)
        .catch(done.fail);
    });

    it('adds hll class to lineContent when line is the highlighted row', done => {
      vm.$nextTick()
        .then(() => {
          vm.$store.state.diffs.highlightedRow = rightLine.line_code;

          return vm.$nextTick();
        })
        .then(() => {
          expect(vm.$el.querySelector('.line_content.right-side').classList).toContain('hll');
          expect(vm.$el.querySelector('.line_content.left-side').classList).toContain('hll');
        })
        .then(done)
        .catch(done.fail);
    });
  });
});
