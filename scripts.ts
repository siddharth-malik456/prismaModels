import { PrismaClient } from '@prisma/client'
declare global {
  var prisma: PrismaClient | undefined;
}
async function main() {
}

main()
.catch(e => {
  console.error(e);
})


export const db = globalThis.prisma || new PrismaClient();
if (process.env.NODE_ENV !== "production") globalThis.prisma = db;