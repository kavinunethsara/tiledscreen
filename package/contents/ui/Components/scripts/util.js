// This keeps track of the tile config and automatically updates the model
class TileData {
  constructor(root, defaults) {
    this.root = root;
    this.model = root.model;
    this.metadata = JSON.parse(this.model.metadata);

    const dataObj = Object.entries(defaults);

    dataObj.forEach(([key, _value]) => {
      this.__defineGetter__(key, () =>
        this.metadata.hasOwnProperty(key) ? this.metadata[key] : defaults[key],
      );

      this.__defineSetter__(key, (val) => {
        this.metadata[key] = val;
        this.model.metadata = JSON.stringify(this.metadata);
        this.setChange();
      });
    });
  }

  get height() {
    return this.model.tileHeight;
  }

  set height(value) {
    this.model.tileHeight = value;
    this.setChange();
  }

  get width() {
    return this.model.tileWidth;
  }

  set width(value) {
    this.model.tileWidth = value;
    this.setChange();
  }

  setChange() {
    this.root.configChanged();
    this.root.tileData = this.metadata;
  }
}

/**
 * Finds the coordinates and value of the closest element in a specific direction.
 *
 * @param {Array<Array<any>>} arr The 2D array.
 * @param {number} startRow The starting row index.
 * @param {number} startCol The starting column index.
 * @param {{row: number, col: number}} direction The direction to search (e.g., {row: 0, col: 1} for East).
 * @param {any} [targetValue=undefined] The specific value to find. If undefined, finds the first non-empty/non-null value.
 * @returns {{row: number, col: number, value: any} | null} The coordinates and value of the found element, or null if none found.
 */
function findClosestInDirection(
  arr,
  startRow,
  startCol,
  direction,
  targetValue = undefined,
) {
  const numRows = arr.length;
  // Handle empty array case
  if (numRows === 0) {
    return null;
  }

  let currentRow = startRow + direction.row;
  let currentCol = startCol + direction.col;

  // Continue searching as long as we are within array boundaries
  while (currentRow >= 0 && currentRow < numRows && currentCol >= 0) {
    if (currentCol >= arr[currentRow].length) {
      if (direction.row == 0 && direction.col > 0) {
        break;
      } else {
        currentRow += direction.row;
        continue;
      }
    }

    const currentValue = arr[currentRow][currentCol];

    // Check if the current element matches the condition (non-empty or specific target)
    if (targetValue !== undefined) {
      if (currentValue === targetValue) {
        return { row: currentRow, col: currentCol, value: currentValue };
      }
    } else {
      // Treat null, undefined, etc. as "empty"
      if (
        currentValue !== null &&
        currentValue !== undefined &&
        currentValue !== ""
      ) {
        return { row: currentRow, col: currentCol, value: currentValue };
      }
    }

    // Move to the next cell in the specified direction
    currentRow += direction.row;
    currentCol += direction.col;
  }

  // No matching element found in the given direction
  return null;
}
