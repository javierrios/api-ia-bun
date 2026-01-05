import Cerebras from '@cerebras/cerebras_cloud_sdk';
import type { IAService, ChatMessage } from './types';

const cerebras = new Cerebras();

export const cerebrasService: IAService = {
    name: 'Cerebras',
    async chat(messages: ChatMessage[]): Promise<AsyncIterable<string>>{
        const stream = await cerebras.chat.completions.create({
            messages:messages as any,
            model: 'zai-glm-4.6',
            stream: true,
            max_completion_tokens: 40960,
            temperature: 0.6,
            top_p: 0.95
        });     

        return async function*(): AsyncIterable<string>{
            for await (const chunk of stream) {
                yield (chunk as any).choices[0]?.delta?.content || '';
            }
        } as unknown as AsyncIterable<string>;
    }
} as IAService satisfies IAService; 