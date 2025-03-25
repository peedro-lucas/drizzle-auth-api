// Define os pontos de corte para os percentis
const percentilKeys = [1, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 99];

// Define os percentis para os dados do Brasil (Geral)
const allGeneral = [
  [191, 166, 140, 132, 123, 110, 101, 93, 87, 81, 77, 73, 68, 61, 59, 55, 52, 42, 36, 25, 17],
  [179, 112, 91, 78, 71, 62, 58, 54, 50, 47, 44, 40, 37, 34, 31, 28, 27, 23, 20, 13],
  [112, 87, 70, 61, 55, 50, 46, 42, 39, 37, 35, 33, 32, 30, 28, 27, 25, 23, 21, 19, 16],
  [104, 53, 42, 36, 32, 30, 29, 28, 26, 25, 25, 24, 23, 22, 21, 20, 19, 16, 16, 15, 12],
  [-1, 54, 34, 29, 26, 25, 24, 24, 23, 22, 22, 20, 20, 19, 18, 17, 17, 16, 13, 12, 11],
  [-1, 54, 34, 29, 26, 25, 24, 24, 23, 22, 22, 20, 20, 19, 18, 17, 17, 16, 13, 12, 11],
  [-1, 54, 34, 29, 26, 25, 24, 24, 23, 22, 22, 20, 20, 19, 18, 17, 17, 16, 13, 12, 11],
  [-1, 54, 34, 29, 26, 25, 24, 24, 23, 22, 22, 20, 20, 19, 18, 17, 17, 16, 13, 12, 11],
  [-1, 54, 34, 29, 26, 25, 24, 24, 23, 22, 22, 20, 20, 19, 18, 17, 17, 16, 13, 12, 11],
];

// Define os percentis para os dados do Nordeste
const allNord = [
  [-1, -2, 86, 75, 73, 67, 61, 60, 58, 53, 51, 46, 39, 37, 34, 33, 32, 31, 29, 26, 26],
  [-1, -2, 86, 75, 73, 67, 61, 60, 58, 53, 51, 46, 39, 37, 34, 33, 32, 31, 29, 26, 26],
  [-1, -2, 86, 75, 73, 67, 61, 60, 58, 53, 51, 46, 39, 37, 34, 33, 32, 31, 29, 26, 26],
  [-1, -2, 77, 59, 56, 55, 50, 49, 44, 40, 36, 32, 31, 25, 25, 24, 23, 22, 20, 16, 16],
  [-1, -2, 62, 57, 55, 54, 51, 47, 40, 33, 27, 27, 26, 25, 24, 24, 23, 21, 20, 20, 20],
  [-1, -2, 62, 57, 55, 54, 51, 47, 40, 33, 27, 27, 26, 25, 24, 24, 23, 21, 20, 20, 20],
  [-1, -2, 62, 57, 55, 54, 51, 47, 40, 33, 27, 27, 26, 25, 24, 24, 23, 21, 20, 20, 20],
  [-1, -2, 62, 57, 55, 54, 51, 47, 40, 33, 27, 27, 26, 25, 24, 24, 23, 21, 20, 20, 20],
  [-1, -2, 62, 57, 55, 54, 51, 47, 40, 33, 27, 27, 26, 25, 24, 24, 23, 21, 20, 20, 20],
];

// Define os percentis para os dados do Sudeste
const allSude = [
  [178, 105, 95, 82, 79, 76, 72, 68, 62, 61, 60, 57, 53, 52, 44, 40, 37, 33, 25, 21, 13],
  [97, 77, 61, 54, 49, 47, 40, 38, 37, 35, 34, 33, 30, 29, 27, 26, 24, 22, 20, 18, 2],
  [89, 60, 47, 42, 39, 37, 34, 33, 31, 30, 28, 27, 25, 24, 23, 22, 21, 20, 19, 17, 13],
  [-1, 36, 34, 31, 29, 29, 28, 26, 25, 25, 24, 23, 22, 21, 20, 20, 17, 16, 15, 15, 12],
  [-1, 29, 27, 25, 24, 24, 23, 22, 22, 20, 20, 19, 18, 18, 17, 17, 16, 15, 13, 12, 11],
  [-1, 29, 27, 25, 24, 24, 23, 22, 22, 20, 20, 19, 18, 18, 17, 17, 16, 15, 13, 12, 11],
  [-1, 29, 27, 25, 24, 24, 23, 22, 22, 20, 20, 19, 18, 18, 17, 17, 16, 15, 13, 12, 11],
  [-1, 29, 27, 25, 24, 24, 23, 22, 22, 20, 20, 19, 18, 18, 17, 17, 16, 15, 13, 12, 11],
  [-1, 29, 27, 25, 24, 24, 23, 22, 22, 20, 20, 19, 18, 18, 17, 17, 16, 15, 13, 12, 11],
];

// Define os percentis para os dados do Centro-Oeste
const allCenoe = [
  [198, 176, 165, 146, 138, 133, 131, 126, 117, 111, 109, 98, 94, 89, 87, 81, 74, 70, 60, 53, 37],
  [189, 147, 112, 97, 89, 80, 74, 68, 63, 61, 57, 54, 51, 48, 46, 42, 39, 36, 34, 28, 18],
  [120, 95, 82, 71, 63, 60, 55, 50, 47, 45, 42, 39, 36, 35, 33, 31, 30, 28, 26, 23, 27],
  [120, 95, 82, 71, 63, 60, 55, 50, 47, 45, 42, 39, 36, 35, 33, 31, 30, 28, 26, 23, 27],
  [120, 95, 82, 71, 63, 60, 55, 50, 47, 45, 42, 39, 36, 35, 33, 31, 30, 28, 26, 23, 27],
  [120, 95, 82, 71, 63, 60, 55, 50, 47, 45, 42, 39, 36, 35, 33, 31, 30, 28, 26, 23, 27],
  [120, 95, 82, 71, 63, 60, 55, 50, 47, 45, 42, 39, 36, 35, 33, 31, 30, 28, 26, 23, 27],
  [120, 95, 82, 71, 63, 60, 55, 50, 47, 45, 42, 39, 36, 35, 33, 31, 30, 28, 26, 23, 27],
  [120, 95, 82, 71, 63, 60, 55, 50, 47, 45, 42, 39, 36, 35, 33, 31, 30, 28, 26, 23, 27],
];

// Cria um mapa de percentis
function createPercentilMap(data: (number[] | null)[]) {
  return data.map((group) => {
    if (group === null) return new Map<number, number>();
    return new Map<number, number>(percentilKeys.map((key, i) => [key, group[i] ?? null]));
  });
}

// Define os percentis para cada região
const percentils = {
  Geral: new Map<number, Map<number, number>>(createPercentilMap(allGeneral).map((map, i) => [i + 1, map])),
  Nordeste: new Map<number, Map<number, number>>(createPercentilMap(allNord).map((map, i) => [i + 1, map])),
  Sudeste: new Map<number, Map<number, number>>(createPercentilMap(allSude).map((map, i) => [i + 1, map])),
  "Centro-Oeste": new Map<number, Map<number, number>>(createPercentilMap(allCenoe).map((map, i) => [i + 1, map])),
};

// Retorna o percentil de um valor
export function getPercentilResult(score: number, grade: number, region: Region = "Geral") {
  const base = percentils[region];

  if (base.get(grade)?.size === 0) {
    return -1;
  }

  const gradePercentils = base.get(grade)!;

  const valueKeys = getKeysByValue(gradePercentils, score);

  let percentil = 0;

  if (valueKeys.length > 0) {
    percentil = valueKeys.at(-1)!;
  } else {
    const availableScores = Array.from(gradePercentils.values()).filter((v) => v > 0);
    const lessScores = availableScores.filter((s) => s < score);
    const greaterScores = availableScores.filter((s) => s > score);

    const lessNextScore = lessScores[0];
    const greaterNextScore = greaterScores.at(-1);

    if (!lessNextScore) {
      percentil = 99;
    } else if (!greaterNextScore) {
      percentil = 1;
    } else {
      const lessDistance = score - lessNextScore;
      const greaterDistance = greaterNextScore - score;

      if (lessDistance <= greaterDistance) {
        percentil = getKeysByValue(gradePercentils, lessNextScore)[0]!;
      } else {
        percentil = getKeysByValue(gradePercentils, greaterNextScore)[0]!;
      }
    }
  }

  return percentil;
}

// Retorna o percentual de um valor
function getKeysByValue(map: Map<number, number>, value: number) {
  const keys: number[] = [];

  map.forEach((v, k) => {
    if (v === value) {
      keys.push(k);
    }
  });

  return keys;
}

export type Region = "Geral" | "Nordeste" | "Sudeste" | "Centro-Oeste";
