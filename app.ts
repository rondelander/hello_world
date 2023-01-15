// Express app with hello world endpoint
import express, {Request, Response} from 'express';
import { json } from 'body-parser';

const app = express();
app.use(json());

app.get('/hello', (req: Request, res: Response) => {
  res.json({message: 'Hello World!'});
});

app.listen(3000, () => {
  console.log('Listening on port 3000');
});
